import XCTest
@testable import Quotio

final class AvailableModelTests: XCTestCase {
    func testBuiltInModelListIncludesGPT54Variants() {
        let openAIModelNames = AvailableModel.allModels
            .filter { $0.provider == "openai" }
            .map(\.name)

        XCTAssertTrue(openAIModelNames.contains("gpt-5.4"))
        XCTAssertTrue(openAIModelNames.contains("gpt-5.4-codex"))
        XCTAssertTrue(openAIModelNames.contains("gpt-5.4-codex-mini"))
    }

    func testSavedModelSlotsPreserveGPT54Selections() {
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
        XCTAssertEqual(configuration.modelSlots[ModelSlot.sonnet], "gpt-5.4-codex")
        XCTAssertEqual(configuration.modelSlots[ModelSlot.haiku], "gpt-5.4-codex-mini")
    }
}
