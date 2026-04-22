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
