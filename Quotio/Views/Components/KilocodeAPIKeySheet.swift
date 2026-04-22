//
//  KilocodeAPIKeySheet.swift
//  Quotio
//
//  Simplified API key configuration sheet for the Kilo Code AI Gateway.
//  Stored under the hood as an OpenAI-compatible CustomProvider with
//  baseURL https://api.kilo.ai/api/gateway.
//
//  The Kilo Gateway is OpenAI-compatible: it exposes the standard
//  /chat/completions endpoint and authenticates via Bearer API key.
//  Models are referenced as "<provider>/<model>", e.g.
//  anthropic/claude-sonnet-4.5 or kilo/auto (smart-routing).
//

import SwiftUI

// MARK: - Marker

/// Marker used to identify a CustomProvider entry that represents a
/// first-class Kilo Code Gateway account (as opposed to a generic OpenAI-compatible provider).
///
/// `nonisolated` for symmetry with the other markers (also lets non-main-actor
/// callers read its constants without hopping actors).
nonisolated enum KilocodeProviderMarker {
    static let baseURL = "https://api.kilo.ai/api/gateway"
    static let defaultName = "Kilo Code"
    static let defaultModel = "kilo/auto"

    static func isKilocode(_ provider: CustomProvider) -> Bool {
        provider.type == .openaiCompatibility &&
        provider.baseURL.lowercased() == baseURL
    }
}

// MARK: - Sheet

struct KilocodeAPIKeySheet: View {
    @Environment(\.dismiss) private var dismiss

    let provider: CustomProvider?
    let onSave: (CustomProvider) -> Void

    @State private var name: String = KilocodeProviderMarker.defaultName
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
                    .fill(AIProvider.kilocode.color.opacity(0.15))
                    .frame(width: 36, height: 36)
                Image(systemName: AIProvider.kilocode.iconName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AIProvider.kilocode.color)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(isEditing ? "Edit Kilo Code Account" : "Add Kilo Code Account")
                    .font(.headline)
                Text("Unified gateway to hundreds of models via api.kilo.ai")
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
                Text("A label for this account. Useful when you have multiple Kilo keys.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                TextField("Kilo Code", text: $name)
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
                Text("Get a key from app.kilo.ai → API Keys, then add credits to start using paid models.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                SecureField("kc-...", text: $apiKey)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(.body, design: .monospaced))
                Link("Open Kilo Code Dashboard",
                     destination: URL(string: "https://app.kilo.ai/")!)
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
                    Text(KilocodeProviderMarker.baseURL)
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(.primary)
                    Spacer()
                }
                Text("Routed via the local proxy as an OpenAI-compatible upstream. Reference any gateway model by its slug, e.g. anthropic/claude-sonnet-4.5, openai/gpt-5.2, or kilo/auto for smart-routing.")
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
            Button(isEditing ? "Save Changes" : "Add Kilo Code") {
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

        // Leave models empty by default — Kilo Gateway accepts any of its dynamic catalog.
        let preservedModels: [ModelMapping] = provider?.models ?? []

        let newProvider = CustomProvider(
            id: provider?.id ?? UUID(),
            name: trimmedName,
            type: .openaiCompatibility,
            baseURL: KilocodeProviderMarker.baseURL,
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
    KilocodeAPIKeySheet(provider: nil) { _ in }
}
