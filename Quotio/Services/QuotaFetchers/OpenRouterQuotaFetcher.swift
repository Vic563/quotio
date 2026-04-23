//
//  OpenRouterQuotaFetcher.swift
//  Quotio
//
//  Fetches credit balance information from the OpenRouter API.
//  Endpoint: GET https://openrouter.ai/api/v1/credits
//  Auth:     Authorization: Bearer <OPENROUTER_API_KEY>
//
//  Response shape (per OpenRouter docs):
//    { "data": { "total_credits": <number>, "total_usage": <number> } }
//
//  Both fields are denominated in USD. We surface them as a single
//  "Credits" ModelQuota with percentage = remaining/total * 100.
//

import Foundation

// MARK: - API Response Models

struct OpenRouterCreditsResponse: Codable, Sendable {
    let data: OpenRouterCreditsData?
}

struct OpenRouterCreditsData: Codable, Sendable {
    let totalCredits: Double
    let totalUsage: Double

    enum CodingKeys: String, CodingKey {
        case totalCredits = "total_credits"
        case totalUsage = "total_usage"
    }
}

nonisolated private struct OpenRouterModelsResponse: Codable, Sendable {
    let data: [OpenRouterModelData]
}

nonisolated private struct OpenRouterModelData: Codable, Sendable {
    let id: String
}

nonisolated private struct OpenRouterModelCatalogSnapshot: Codable, Sendable {
    let modelIDs: [String]
    let fetchedAt: Date
}

nonisolated enum OpenRouterModelCatalogCache {
    private static let storageKey = "openRouterModelCatalogSnapshot"

    static func loadModelIDs(maxAge: TimeInterval? = nil, now: Date = Date()) -> [String] {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let snapshot = try? JSONDecoder().decode(OpenRouterModelCatalogSnapshot.self, from: data) else {
            return []
        }

        if let maxAge, now.timeIntervalSince(snapshot.fetchedAt) > maxAge {
            return []
        }

        return snapshot.modelIDs
    }

    @MainActor
    static func load(maxAge: TimeInterval? = nil, now: Date = Date()) -> [ModelMapping] {
        loadModelIDs(maxAge: maxAge, now: now).map { ModelMapping(name: $0, alias: $0) }
    }

    static func saveModelIDs(_ modelIDs: [String], now: Date = Date()) {
        let modelIDs = modelIDs
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .uniqued()

        guard !modelIDs.isEmpty else { return }

        let snapshot = OpenRouterModelCatalogSnapshot(modelIDs: modelIDs, fetchedAt: now)
        guard let data = try? JSONEncoder().encode(snapshot) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    @MainActor
    static func save(_ mappings: [ModelMapping], now: Date = Date()) {
        saveModelIDs(mappings.map(\.name), now: now)
    }
}

actor OpenRouterModelCatalogService {
    static let shared = OpenRouterModelCatalogService()

    private let modelsURL = "https://openrouter.ai/api/v1/models"
    private let cacheTTL: TimeInterval = 12 * 60 * 60
    private var memoryCache: (modelIDs: [String], fetchedAt: Date)?
    private var session: URLSession

    init() {
        let config = ProxyConfigurationService.createProxiedConfigurationStatic(timeout: 20)
        self.session = URLSession(configuration: config)
    }

    func updateProxyConfiguration() {
        let config = ProxyConfigurationService.createProxiedConfigurationStatic(timeout: 20)
        self.session = URLSession(configuration: config)
    }

    func fetchModelMappings(apiKey: String? = nil, forceRefresh: Bool = false) async throws -> [ModelMapping] {
        let now = Date()

        if !forceRefresh {
            if let memoryCache, now.timeIntervalSince(memoryCache.fetchedAt) <= cacheTTL {
                return await mappings(from: memoryCache.modelIDs)
            }

            let diskModelIDs = OpenRouterModelCatalogCache.loadModelIDs(maxAge: cacheTTL, now: now)
            if !diskModelIDs.isEmpty {
                memoryCache = (diskModelIDs, now)
                return await mappings(from: diskModelIDs)
            }
        }

        guard let url = URL(string: modelsURL) else {
            throw QuotaFetchError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.addValue(OpenRouterProviderMarker.httpReferer, forHTTPHeaderField: "HTTP-Referer")
        request.addValue(OpenRouterProviderMarker.xTitle, forHTTPHeaderField: "X-Title")

        let normalizedKey = apiKey.map(OpenRouterProviderMarker.normalizedAPIKey) ?? ""
        if !normalizedKey.isEmpty {
            request.addValue("Bearer \(normalizedKey)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw QuotaFetchError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw QuotaFetchError.httpError(httpResponse.statusCode)
        }

        let decoded = try JSONDecoder().decode(OpenRouterModelsResponse.self, from: data)
        let modelIDs = decoded.data
            .map(\.id)
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .uniqued()
            .sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }

        guard !modelIDs.isEmpty else {
            throw QuotaFetchError.invalidResponse
        }

        memoryCache = (modelIDs, now)
        OpenRouterModelCatalogCache.saveModelIDs(modelIDs, now: now)
        return await mappings(from: modelIDs)
    }

    private func mappings(from modelIDs: [String]) async -> [ModelMapping] {
        await MainActor.run {
            modelIDs.map { ModelMapping(name: $0, alias: $0) }
        }
    }
}

// MARK: - Quota Fetcher

actor OpenRouterQuotaFetcher {
    private let creditsURL = "https://openrouter.ai/api/v1/credits"
    private var session: URLSession

    init() {
        let config = ProxyConfigurationService.createProxiedConfigurationStatic(timeout: 15)
        self.session = URLSession(configuration: config)
    }

    /// Update the URLSession with current proxy settings
    func updateProxyConfiguration() {
        let config = ProxyConfigurationService.createProxiedConfigurationStatic(timeout: 15)
        self.session = URLSession(configuration: config)
    }

    /// Fetch credit balance for a single API key.
    func fetchQuota(apiKey: String) async throws -> ProviderQuotaData {
        guard let url = URL(string: creditsURL) else {
            throw QuotaFetchError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        // Optional attribution headers — OpenRouter accepts/ignores them on this endpoint
        // but they're harmless and keep us consistent with the chat-completions side.
        request.addValue(OpenRouterProviderMarker.httpReferer, forHTTPHeaderField: "HTTP-Referer")
        request.addValue(OpenRouterProviderMarker.xTitle, forHTTPHeaderField: "X-Title")

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw QuotaFetchError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            // 401 is the expected response for keys without management/credits scope —
            // surface as a forbidden state so the UI doesn't show an error toast.
            if httpResponse.statusCode == 401 || httpResponse.statusCode == 403 {
                return await MainActor.run { ProviderQuotaData(isForbidden: true) }
            }
            throw QuotaFetchError.httpError(httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        let parsed = try await MainActor.run {
            try decoder.decode(OpenRouterCreditsResponse.self, from: data)
        }

        guard let credits = parsed.data else {
            throw QuotaFetchError.invalidResponse
        }

        return await MainActor.run {
            let total = credits.totalCredits
            let used = credits.totalUsage
            let remaining = max(0, total - used)

            let percentage: Double
            if total > 0 {
                percentage = min(100, max(0, remaining / total * 100))
            } else {
                // Pay-as-you-go account with no purchased credits — report as unknown
                // so the UI shows "—" instead of 0%.
                percentage = -1
            }

            // Convert dollars to integer cents for the used/limit/remaining fields,
            // which expect Int. This preserves enough precision for typical OpenRouter
            // balances (whole-cent accuracy is plenty for a dashboard widget).
            let usedCents = Int((used * 100).rounded())
            let totalCents = Int((total * 100).rounded())
            let remainingCents = Int((remaining * 100).rounded())

            let model = ModelQuota(
                name: "Credits",
                percentage: percentage,
                resetTime: "",
                used: usedCents,
                limit: totalCents,
                remaining: remainingCents,
                tooltip: "USD credits — total $\(String(format: "%.2f", total)), used $\(String(format: "%.2f", used)), remaining $\(String(format: "%.2f", remaining))"
            )

            return ProviderQuotaData(models: [model], lastUpdated: Date())
        }
    }

    /// Fetch quota for every configured OpenRouter custom provider.
    /// Keys are the provider's display name so the UI can show multiple accounts.
    func fetchAllQuotas() async -> [String: ProviderQuotaData] {
        let providers = await getOpenRouterProviders()

        var results: [String: ProviderQuotaData] = [:]

        await withTaskGroup(of: (String, ProviderQuotaData?).self) { group in
            for provider in providers {
                guard let firstKey = provider.apiKeys.first?.apiKey, !firstKey.isEmpty else {
                    continue
                }
                group.addTask {
                    do {
                        let quota = try await self.fetchQuota(apiKey: firstKey)
                        return (provider.name, quota)
                    } catch {
                        return ("", nil)
                    }
                }
            }

            for await (key, quota) in group {
                if !key.isEmpty, let quota = quota {
                    results[key] = quota
                }
            }
        }

        return results
    }

    private func getOpenRouterProviders() async -> [CustomProvider] {
        await MainActor.run {
            CustomProviderService.shared.providers.filter {
                OpenRouterProviderMarker.isOpenRouter($0) && $0.isEnabled
            }
        }
    }
}

private extension Array where Element: Hashable {
    nonisolated func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
