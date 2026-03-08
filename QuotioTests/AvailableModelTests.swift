import XCTest
@testable import Quotio

final class AvailableModelTests: XCTestCase {
    func testLegacyModelNamesNormalizeToSupportedReplacements() {
        XCTAssertEqual(AvailableModel.normalizedModelName("gpt-5.4"), "gpt-5")
        XCTAssertEqual(AvailableModel.normalizedModelName("gpt-5.4-codex"), "gpt-5-codex")
        XCTAssertEqual(AvailableModel.normalizedModelName("gpt-5.4-codex-mini"), "gpt-5-codex-mini")
        XCTAssertEqual(AvailableModel.normalizedModelName("gpt-5"), "gpt-5")
    }

    func testSanitizedModelsDeduplicatesLegacyAliases() {
        let sanitizedModels = AvailableModel.sanitizedModels([
            AvailableModel(id: "gpt-5.4", name: "gpt-5.4", provider: "openai", isDefault: false),
            AvailableModel(id: "gpt-5", name: "gpt-5", provider: "openai", isDefault: false),
            AvailableModel(id: "gpt-5.4-codex", name: "gpt-5.4-codex", provider: "openai", isDefault: false),
            AvailableModel(id: "gpt-5-codex", name: "gpt-5-codex", provider: "openai", isDefault: false)
        ])

        XCTAssertEqual(sanitizedModels.map(\.id), ["gpt-5", "gpt-5-codex"])
    }
}
