import Foundation

enum RuntimeEnvironment {
    nonisolated static let isRunningUnitTests =
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}
