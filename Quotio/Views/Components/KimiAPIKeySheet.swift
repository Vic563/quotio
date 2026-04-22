//
//  KimiAPIKeySheet.swift
//  Quotio
//
//  Simplified API key configuration sheet for Moonshot Kimi models.
//  Stored under the hood as an OpenAI-compatible CustomProvider with
//  baseURL https://api.moonshot.ai/v1 and the kimi-k2.6 model preconfigured.
//

import SwiftUI

// MARK: - Marker

/// Marker used to identify a CustomProvider entry that represents a
/// first-class Moonshot/Kimi account (as opposed to a generic OpenAI-compatible provider).
enum KimiProviderMarker {
    static let baseURL = "https://api.moonshot.ai/v1"
    static let defaultName = "Kimi"
    static let defaultModel = "kimi-k2.6"

    static func isMoonshot(_ provider: CustomProvider) -> Bool {
        provider.type == .openaiCompatibility &&
        provider.baseURL.lowercased() == baseURL
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
                Text("Connect to Moonshot's Kimi K2.6 via api.moonshot.ai")
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
                Text("Get a key from platform.moonshot.ai → API Keys.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                SecureField("sk-...", text: $apiKey)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(.body, design: .monospaced))
                Link("Open Moonshot Platform",
                     destination: URL(string: "https://platform.moonshot.ai/console/api-keys")!)
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
                    Text(KimiProviderMarker.baseURL)
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(.primary)
                    Spacer()
                }
                Text("Routed via the local proxy as an OpenAI-compatible upstream. The kimi-k2.6 model is preconfigured.")
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
            preservedModels = [
                ModelMapping(name: KimiProviderMarker.defaultModel,
                             alias: KimiProviderMarker.defaultModel)
            ]
        }

        let newProvider = CustomProvider(
            id: provider?.id ?? UUID(),
            name: trimmedName,
            type: .openaiCompatibility,
            baseURL: KimiProviderMarker.baseURL,
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
    KimiAPIKeySheet(provider: nil) { _ in }
}
