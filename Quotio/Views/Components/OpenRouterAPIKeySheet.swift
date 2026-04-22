//
//  OpenRouterAPIKeySheet.swift
//  Quotio
//
//  Simplified API key configuration sheet for OpenRouter.
//  Stored under the hood as an OpenAI-compatible CustomProvider with
//  baseURL https://openrouter.ai/api/v1.
//
//  OpenRouter is OpenAI-compatible: any chat-completions client can talk
//  to it by setting the base URL and a Bearer API key.
//  Optional headers (HTTP-Referer / X-Title) are added so requests show
//  up under "Quotio" on OpenRouter's leaderboards.
//

import SwiftUI

// MARK: - Marker

/// Marker used to identify a CustomProvider entry that represents a
/// first-class OpenRouter account (as opposed to a generic OpenAI-compatible provider).
///
/// `nonisolated` so the OpenRouterQuotaFetcher actor can read its constants
/// without needing to hop to the main actor (project's default isolation is MainActor).
nonisolated enum OpenRouterProviderMarker {
    static let baseURL = "https://openrouter.ai/api/v1"
    static let defaultName = "OpenRouter"
    static let defaultModel = "openrouter/auto"
    static let httpReferer = "https://github.com/quotio/quotio"
    static let xTitle = "Quotio"

    static func isOpenRouter(_ provider: CustomProvider) -> Bool {
        provider.type == .openaiCompatibility &&
        provider.baseURL.lowercased() == baseURL
    }
}

// MARK: - Sheet

struct OpenRouterAPIKeySheet: View {
    @Environment(\.dismiss) private var dismiss

    let provider: CustomProvider?
    let onSave: (CustomProvider) -> Void

    @State private var name: String = OpenRouterProviderMarker.defaultName
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
        .frame(width: 480, height: 460)
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
                    .fill(AIProvider.openrouter.color.opacity(0.15))
                    .frame(width: 36, height: 36)
                Image(systemName: AIProvider.openrouter.iconName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AIProvider.openrouter.color)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(isEditing ? "Edit OpenRouter Account" : "Add OpenRouter Account")
                    .font(.headline)
                Text("Route requests to hundreds of models via openrouter.ai")
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
                Text("A label for this account. Useful when you have multiple OpenRouter keys.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                TextField("OpenRouter", text: $name)
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
                Text("Create a key at openrouter.ai → Keys. Optionally set a credit limit per key.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                SecureField("sk-or-v1-...", text: $apiKey)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(.body, design: .monospaced))
                Link("Open OpenRouter Keys",
                     destination: URL(string: "https://openrouter.ai/settings/keys")!)
                    .font(.caption)
            }
        }
        .padding(16)
        .background(Color(.controlBackgroundColor).opacity(0.5))
        .cornerRadius(8)
    }

    private var endpointSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Endpoint")
                .font(.headline)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: "link")
                        .foregroundStyle(.secondary)
                    Text(OpenRouterProviderMarker.baseURL)
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(.primary)
                    Spacer()
                }
                Text("Routed via the local proxy as an OpenAI-compatible upstream. Use any model from openrouter.ai with its full slug, e.g. anthropic/claude-sonnet-4.5 or openai/gpt-5.2.")
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
            Button(isEditing ? "Save Changes" : "Add OpenRouter") {
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
        let trimmedKey = apiKey.trimmingCharacters(in: .whitespaces)

        if trimmedName.isEmpty {
            validationError = "Account name is required."
            showValidationAlert = true
            return
        }
        if trimmedKey.isEmpty {
            validationError = "API key is required."
            showValidationAlert = true
            return
        }

        let preservedModels: [ModelMapping]
        if let provider, !provider.models.isEmpty {
            preservedModels = provider.models
        } else {
            // Leave model list empty so the proxy passes-through any OpenRouter slug.
            // Users can add specific aliases via the generic Custom Provider editor if desired.
            preservedModels = []
        }

        // Attribution headers so requests show up as "Quotio" on OpenRouter's leaderboards.
        // Only relevant for the openai-compatibility upstream, but harmless to omit too —
        // CustomProvider's openai-compatibility codepath ignores `headers`. We keep the
        // marker minimal and rely on OpenRouter's defaults.
        let newProvider = CustomProvider(
            id: provider?.id ?? UUID(),
            name: trimmedName,
            type: .openaiCompatibility,
            baseURL: OpenRouterProviderMarker.baseURL,
            apiKeys: [CustomAPIKeyEntry(apiKey: trimmedKey)],
            models: preservedModels,
            isEnabled: true,
            createdAt: provider?.createdAt ?? Date(),
            updatedAt: Date()
        )

        onSave(newProvider)
        dismiss()
    }
}

#Preview {
    OpenRouterAPIKeySheet(provider: nil) { _ in }
}
