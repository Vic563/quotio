import XCTest
@testable import Quotio

final class AvailableModelTests: XCTestCase {
    func testBuiltInModelListIncludesOnlyRealGPT54Variant() {
        let openAIModelNames = AvailableModel.allModels
            .filter { $0.provider == "openai" }
            .map(\.name)

        XCTAssertTrue(openAIModelNames.contains("gpt-5.4"))
        XCTAssertFalse(openAIModelNames.contains("gpt-5.4-codex"))
        XCTAssertFalse(openAIModelNames.contains("gpt-5.4-codex-mini"))
    }

    func testSavedModelSlotsNormalizeRemovedGPT54CodexVariants() {
        let configuration = AgentConfiguration(
            agent: .codexCLI,
            proxyURL: "http://localhost:8000",
            apiKey: "test-key",
            savedModelSlots: [
                ModelSlot.opus: "gpt-5.4",
                ModelSlot.sonnet: "gpt-5.4-codex",
                ModelSlot.haiku: "gpt-5.4-codex-mini"
            ]
        )

        XCTAssertEqual(configuration.modelSlots[ModelSlot.opus], "gpt-5.4")
        XCTAssertEqual(configuration.modelSlots[ModelSlot.sonnet], "gpt-5-codex")
        XCTAssertEqual(configuration.modelSlots[ModelSlot.haiku], "gpt-5-codex-mini")
    }

    func testSanitizedModelsDeduplicateRemovedGPT54CodexVariants() {
        let sanitizedModels = AvailableModel.sanitizedModels([
            AvailableModel(id: "gpt-5.4-codex", name: "gpt-5.4-codex", provider: "openai", isDefault: false),
            AvailableModel(id: "gpt-5-codex", name: "gpt-5-codex", provider: "openai", isDefault: false),
            AvailableModel(id: "gpt-5.4-codex-mini", name: "gpt-5.4-codex-mini", provider: "openai", isDefault: false),
            AvailableModel(id: "gpt-5-codex-mini", name: "gpt-5-codex-mini", provider: "openai", isDefault: false)
        ])

        XCTAssertEqual(sanitizedModels.map(\.id), ["gpt-5-codex", "gpt-5-codex-mini"])
    }
}
