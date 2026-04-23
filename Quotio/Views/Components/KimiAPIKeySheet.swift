//
//  KimiAPIKeySheet.swift
//  Quotio
//
//  API key configuration sheet for Moonshot's "Kimi For Coding" subscription
//  (the coding-agent product, not the general platform.moonshot.ai API).
//
//  Kimi For Coding lives at https://api.kimi.com/coding and gates access by
//  User-Agent — the upstream rejects requests that don't claim to be one of
//  the supported coding agents (Kimi CLI, Claude Code, Roo, Kilo, etc).
//
//  We persist this as a `claude-api-key` CustomProvider (matches the working
//  configuration documented in CLIProxyAPI issue #1280) with:
//    base-url: "https://api.kimi.com/coding"
//    headers:  { User-Agent: "KimiCLI/1.3" }
//    models:   upstream kimi-for-coding → local alias kimi-k2.6
//

import SwiftUI

// MARK: - Marker

/// Marker used to identify a CustomProvider entry that represents a
/// first-class Kimi For Coding account.
enum KimiProviderMarker {
    /// Canonical base URL for the Kimi For Coding endpoint.
    static let baseURL = "https://api.kimi.com/coding"
    /// Pre-v0.16 base URL that incorrectly pointed at the general Moonshot
    /// platform API. We still recognise this so we can migrate old entries.
    static let legacyBaseURL = "https://api.moonshot.ai/v1"
    static let defaultName = "Kimi"
    /// Upstream model id Kimi For Coding actually serves.
    static let upstreamModel = "kimi-for-coding"
    /// Client-facing model name (what Claude Code sends in `model:`).
    static let defaultModel = "kimi-k2.6"
    /// User-Agent required by Kimi For Coding's upstream gating.
    static let userAgentHeader = "KimiCLI/1.3"

    static func isMoonshot(_ provider: CustomProvider) -> Bool {
        let lowered = provider.baseURL.lowercased()
        // Either the new canonical Kimi-For-Coding endpoint, or the legacy
        // moonshot.ai endpoint that older builds wrote (we'll migrate that on
        // load — see CustomProviderService.migrateKimiProvidersIfNeeded()).
        return lowered == baseURL.lowercased() ||
               lowered == legacyBaseURL.lowercased()
    }

    /// Validate that a string looks like a Moonshot platform API key.
    /// Moonshot keys are issued from platform.moonshot.ai and follow the
    /// OpenAI convention: prefix `sk-`, opaque token of at least ~20 chars,
    /// no whitespace or URL-like characters. We reject obvious non-keys
    /// (URLs, bare words, emails) up-front so they never reach the proxy
    /// and trigger an upstream 401 → cooldown → "auth_unavailable" cascade.
    static func validateAPIKey(_ raw: String) -> String? {
        let key = raw.trimmingCharacters(in: .whitespacesAndNewlines)

        if key.isEmpty {
            return "API key is required."
        }

        if key.rangeOfCharacter(from: .whitespacesAndNewlines) != nil {
            return "API key must not contain whitespace."
        }

        // Reject anything that looks like a URL/hostname/email — common
        // copy-paste mistakes that produce 401s from Moonshot.
        let lower = key.lowercased()
        if lower.hasPrefix("http://") || lower.hasPrefix("https://") {
            return "That looks like a URL, not an API key. Paste the sk-… value from platform.moonshot.ai → API Keys."
        }
        if lower.contains("@") || lower.contains("/") {
            return "That doesn't look like a Moonshot API key. Paste the sk-… value from platform.moonshot.ai → API Keys."
        }
        // Any internal "." (e.g. "jules.google.com") is a strong signal this
        // is a hostname, not an opaque key. Real Moonshot keys are dot-free.
        if key.contains(".") {
            return "That doesn't look like a Moonshot API key. Paste the sk-… value from platform.moonshot.ai → API Keys."
        }

        if !key.lowercased().hasPrefix("sk-") {
            return "Moonshot API keys start with \"sk-\". Get one from platform.moonshot.ai → API Keys."
        }

        if key.count < 20 {
            return "API key looks too short. Copy the full sk-… value from platform.moonshot.ai → API Keys."
        }

        return nil
    }
}

// MARK: - Sheet

struct KimiAPIKeySheet: View {
    @Environment(\.dismiss) private var dismiss

    let provider: CustomProvider?
    let onSave: (CustomProvider) -> Void

    @State private var name: String = KimiProviderMarker.defaultName
    @State private var apiKey: String = ""
    @State private var validationError: String?
    @State private var showValidationAlert = false

    private var isEditing: Bool { provider != nil }

    var body: some View {
        VStack(spacing: 0) {
            headerView
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    nameSection
                    apiKeySection
                    endpointSection
                }
                .padding(20)
            }
            Divider()
            footerView
        }
        .frame(width: 480, height: 420)
        .onAppear { loadProviderData() }
        .alert("Validation Error", isPresented: $showValidationAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            if let error = validationError { Text(error) }
        }
    }

    // MARK: - Sections

    private var headerView: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(AIProvider.kimi.color.opacity(0.15))
                    .frame(width: 36, height: 36)
                Image(systemName: AIProvider.kimi.iconName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AIProvider.kimi.color)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(isEditing ? "Edit Kimi Account" : "Add Kimi Account")
                    .font(.headline)
                Text("Connect to Moonshot's Kimi For Coding (Kimi K2.6) via api.kimi.com/coding")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button { dismiss() } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
        }
        .padding(20)
    }

    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Account Name")
                .font(.headline)
            VStack(alignment: .leading, spacing: 8) {
                Text("A label for this account. Useful when you have multiple Moonshot keys.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                TextField("Kimi", text: $name)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(16)
        .background(Color(.controlBackgroundColor).opacity(0.5))
        .cornerRadius(8)
    }

    private var apiKeySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("API Key")
                .font(.headline)
            VStack(alignment: .leading, spacing: 8) {
                Text("Get a key from platform.moonshot.ai → API Keys. Moonshot keys start with \"sk-\".")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                SecureField("sk-...", text: $apiKey)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(.body, design: .monospaced))
                if let inlineHint = inlineKeyHint {
                    Label(inlineHint, systemImage: "exclamationmark.triangle.fill")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }
                Link("Open Moonshot Platform",
                     destination: URL(string: "https://platform.moonshot.ai/console/api-keys")!)
                    .font(.caption)
            }
        }
        .padding(16)
        .background(Color(.controlBackgroundColor).opacity(0.5))
        .cornerRadius(8)
    }

    /// Inline (non-blocking) hint shown beneath the API-key field while the
    /// user is typing. Returns nil when the field is empty (so we don't nag
    /// before they've entered anything) or when the value validates cleanly.
    private var inlineKeyHint: String? {
        let trimmed = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return KimiProviderMarker.validateAPIKey(trimmed)
    }

    private var endpointSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Endpoint")
                .font(.headline)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: "link")
                        .foregroundStyle(.secondary)
                    Text(KimiProviderMarker.baseURL)
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(.primary)
                    Spacer()
                }
                Text("Routed via the local proxy to Kimi For Coding. Quotio sends the required \(KimiProviderMarker.userAgentHeader) header and maps the local kimi-k2.6 alias to the kimi-for-coding upstream model.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .background(Color(.controlBackgroundColor).opacity(0.5))
        .cornerRadius(8)
    }

    private var footerView: some View {
        HStack {
            Button("Cancel") { dismiss() }
                .keyboardShortcut(.escape)
            Spacer()
            Button(isEditing ? "Save Changes" : "Add Kimi") {
                saveProvider()
            }
            .keyboardShortcut(.return, modifiers: .command)
            .buttonStyle(.borderedProminent)
        }
        .padding(20)
    }

    // MARK: - Actions

    private func loadProviderData() {
        guard let provider = provider else { return }
        name = provider.name
        if let firstKey = provider.apiKeys.first {
            apiKey = firstKey.apiKey
        }
    }

    private func saveProvider() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let trimmedKey = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedName.isEmpty {
            validationError = "Account name is required."
            showValidationAlert = true
            return
        }
        if let keyError = KimiProviderMarker.validateAPIKey(trimmedKey) {
            validationError = keyError
            showValidationAlert = true
            return
        }

        // Always write the canonical Kimi-For-Coding model mapping. We
        // intentionally drop any preserved old mapping so edits from the UI
        // always converge on the working upstream id with a local kimi-k2.6 alias.
        let canonicalModels = [
            ModelMapping(name: KimiProviderMarker.upstreamModel,
                         alias: KimiProviderMarker.defaultModel)
        ]

        // Kimi For Coding gates by User-Agent. Without this header upstream
        // returns "access_terminated_error" (see CLIProxyAPI issue #1280).
        let canonicalHeaders = [
            CustomHeader(key: "User-Agent",
                         value: KimiProviderMarker.userAgentHeader)
        ]

        let newProvider = CustomProvider(
            id: provider?.id ?? UUID(),
            name: trimmedName,
            type: .claudeCompatibility,
            baseURL: KimiProviderMarker.baseURL,
            apiKeys: [CustomAPIKeyEntry(apiKey: trimmedKey)],
            models: canonicalModels,
            headers: canonicalHeaders,
            isEnabled: true,
            createdAt: provider?.createdAt ?? Date(),
            updatedAt: Date()
        )

        onSave(newProvider)
        dismiss()
    }
}

#Preview {
    KimiAPIKeySheet(provider: nil) { _ in }
}
