# Quotio/Services/Proxy/CLIProxyManager.swift

[← Back to Module](../modules/Quotio-Services-Proxy/MODULE.md) | [← Back to INDEX](../INDEX.md)

## Overview

- **Lines:** 2121
- **Language:** Swift
- **Symbols:** 69
- **Public symbols:** 0

## Symbol Table

| Line | Kind | Name | Visibility | Signature |
| ---- | ---- | ---- | ---------- | --------- |
| 9 | class | CLIProxyManager | (internal) | `class CLIProxyManager` |
| 243 | method | init | (internal) | `init()` |
| 284 | fn | restartProxyIfRunning | (private) | `private func restartProxyIfRunning()` |
| 302 | fn | updateConfigValue | (private) | `private func updateConfigValue(pattern: String,...` |
| 322 | fn | updateConfigPort | (private) | `private func updateConfigPort(_ newPort: UInt16)` |
| 326 | fn | updateConfigHost | (private) | `private func updateConfigHost(_ host: String)` |
| 330 | fn | ensureApiKeyExistsInConfig | (private) | `private func ensureApiKeyExistsInConfig()` |
| 379 | fn | updateConfigAllowRemote | (internal) | `func updateConfigAllowRemote(_ enabled: Bool)` |
| 383 | fn | updateConfigLogging | (internal) | `func updateConfigLogging(enabled: Bool)` |
| 391 | fn | updateConfigRoutingStrategy | (internal) | `func updateConfigRoutingStrategy(_ strategy: St...` |
| 396 | fn | updateConfigProxyURL | (internal) | `func updateConfigProxyURL(_ url: String?)` |
| 424 | fn | applyBaseURLWorkaround | (internal) | `func applyBaseURLWorkaround()` |
| 453 | fn | removeBaseURLWorkaround | (internal) | `func removeBaseURLWorkaround()` |
| 495 | fn | ensureConfigExists | (private) | `private func ensureConfigExists()` |
| 529 | fn | syncSecretKeyInConfig | (private) | `private func syncSecretKeyInConfig()` |
| 545 | fn | regenerateManagementKey | (internal) | `func regenerateManagementKey() async throws` |
| 587 | fn | syncProxyURLInConfig | (private) | `private func syncProxyURLInConfig()` |
| 604 | fn | syncCustomProvidersToConfig | (private) | `private func syncCustomProvidersToConfig()` |
| 616 | fn | syncCustomProvidersAndRestartIfRunning | (internal) | `func syncCustomProvidersAndRestartIfRunning() a...` |
| 637 | fn | downloadAndInstallBinary | (internal) | `func downloadAndInstallBinary() async throws` |
| 698 | fn | fetchLatestRelease | (private) | `private func fetchLatestRelease() async throws ...` |
| 719 | fn | findCompatibleAsset | (private) | `private func findCompatibleAsset(in release: Re...` |
| 744 | fn | downloadAsset | (private) | `private func downloadAsset(url: String) async t...` |
| 763 | fn | extractAndInstall | (private) | `private func extractAndInstall(data: Data, asse...` |
| 825 | fn | findBinaryInDirectory | (private) | `private func findBinaryInDirectory(_ directory:...` |
| 858 | fn | start | (internal) | `func start() async throws` |
| 990 | fn | waitForBackendReadiness | (private) | `private func waitForBackendReadiness(process: P...` |
| 1007 | fn | waitForBridgeReadiness | (private) | `private func waitForBridgeReadiness(process: Pr...` |
| 1024 | fn | bridgeAcceptsConnections | (private) | `private func bridgeAcceptsConnections(on port: ...` |
| 1051 | fn | terminateProcessIfNeeded | (private) | `private func terminateProcessIfNeeded(_ process...` |
| 1066 | fn | stop | (internal) | `func stop()` |
| 1118 | fn | startHealthMonitor | (private) | `private func startHealthMonitor()` |
| 1132 | fn | stopHealthMonitor | (private) | `private func stopHealthMonitor()` |
| 1137 | fn | performHealthCheck | (private) | `private func performHealthCheck() async` |
| 1200 | fn | cleanupOrphanProcesses | (private) | `private func cleanupOrphanProcesses() async` |
| 1263 | fn | terminateAuthProcess | (internal) | `func terminateAuthProcess()` |
| 1269 | fn | toggle | (internal) | `func toggle() async throws` |
| 1277 | fn | copyEndpointToClipboard | (internal) | `func copyEndpointToClipboard()` |
| 1282 | fn | revealInFinder | (internal) | `func revealInFinder()` |
| 1289 | enum | ProxyError | (internal) | `enum ProxyError` |
| 1320 | enum | AuthCommand | (internal) | `enum AuthCommand` |
| 1358 | struct | AuthCommandResult | (internal) | `struct AuthCommandResult` |
| 1364 | mod | extension CLIProxyManager | (internal) | - |
| 1365 | fn | runAuthCommand | (internal) | `func runAuthCommand(_ command: AuthCommand) asy...` |
| 1397 | fn | appendOutput | (internal) | `func appendOutput(_ str: String)` |
| 1401 | fn | tryResume | (internal) | `func tryResume() -> Bool` |
| 1412 | fn | safeResume | (internal) | `@Sendable func safeResume(_ result: AuthCommand...` |
| 1512 | mod | extension CLIProxyManager | (internal) | - |
| 1542 | fn | checkForUpgrade | (internal) | `func checkForUpgrade() async` |
| 1593 | fn | saveInstalledVersion | (private) | `private func saveInstalledVersion(_ version: St...` |
| 1601 | fn | fetchAvailableReleases | (internal) | `func fetchAvailableReleases(limit: Int = 10) as...` |
| 1623 | fn | versionInfo | (internal) | `func versionInfo(from release: GitHubRelease) -...` |
| 1629 | fn | fetchGitHubRelease | (private) | `private func fetchGitHubRelease(tag: String) as...` |
| 1651 | fn | findCompatibleAsset | (private) | `private func findCompatibleAsset(from release: ...` |
| 1684 | fn | performManagedUpgrade | (internal) | `func performManagedUpgrade(to version: ProxyVer...` |
| 1742 | fn | downloadAndInstallVersion | (private) | `private func downloadAndInstallVersion(_ versio...` |
| 1789 | fn | startDryRun | (private) | `private func startDryRun(version: String) async...` |
| 1860 | fn | promote | (private) | `private func promote(version: String) async throws` |
| 1895 | fn | rollback | (internal) | `func rollback() async throws` |
| 1928 | fn | stopTestProxy | (private) | `private func stopTestProxy() async` |
| 1957 | fn | stopTestProxySync | (private) | `private func stopTestProxySync()` |
| 1983 | fn | findUnusedPort | (private) | `private func findUnusedPort() throws -> UInt16` |
| 1993 | fn | isPortInUse | (private) | `private func isPortInUse(_ port: UInt16) -> Bool` |
| 2012 | fn | createTestConfig | (private) | `private func createTestConfig(port: UInt16) -> ...` |
| 2040 | fn | cleanupTestConfig | (private) | `private func cleanupTestConfig(_ configPath: St...` |
| 2048 | fn | isNewerVersion | (private) | `private func isNewerVersion(_ newer: String, th...` |
| 2051 | fn | parseVersion | (internal) | `func parseVersion(_ version: String) -> [Int]` |
| 2083 | fn | findPreviousVersion | (private) | `private func findPreviousVersion() -> String?` |
| 2096 | fn | migrateToVersionedStorage | (internal) | `func migrateToVersionedStorage() async throws` |

## Memory Markers

### 🟢 `NOTE` (line 274)

> Bridge mode default is registered in AppDelegate.applicationDidFinishLaunching()

### 🟢 `NOTE` (line 390)

> Changes take effect after proxy restart (CLIProxyAPI does not support live routing API)

### 🟢 `NOTE` (line 1576)

> Notification is handled by AtomFeedUpdateService polling

