# Quotio/ViewModels/QuotaViewModel.swift

[← Back to Module](../modules/root/MODULE.md) | [← Back to INDEX](../INDEX.md)

## Overview

- **Lines:** 1986
- **Language:** Swift
- **Symbols:** 94
- **Public symbols:** 0

## Symbol Table

| Line | Kind | Name | Visibility | Signature |
| ---- | ---- | ---- | ---------- | --------- |
| 11 | class | QuotaViewModel | (internal) | `class QuotaViewModel` |
| 141 | fn | loadDisabledAuthFiles | (private) | `private func loadDisabledAuthFiles() -> Set<Str...` |
| 147 | fn | saveDisabledAuthFiles | (private) | `private func saveDisabledAuthFiles(_ names: Set...` |
| 152 | fn | syncDisabledStatesToBackend | (private) | `private func syncDisabledStatesToBackend() async` |
| 171 | fn | notifyQuotaDataChanged | (private) | `private func notifyQuotaDataChanged()` |
| 174 | method | init | (internal) | `init()` |
| 184 | fn | setupProxyURLObserver | (private) | `private func setupProxyURLObserver()` |
| 200 | fn | normalizedProxyURL | (private) | `private func normalizedProxyURL(_ rawValue: Str...` |
| 212 | fn | updateProxyConfiguration | (internal) | `func updateProxyConfiguration() async` |
| 226 | fn | setupRefreshCadenceCallback | (private) | `private func setupRefreshCadenceCallback()` |
| 234 | fn | setupWarmupCallback | (private) | `private func setupWarmupCallback()` |
| 252 | fn | restartAutoRefresh | (private) | `private func restartAutoRefresh()` |
| 264 | fn | initialize | (internal) | `func initialize() async` |
| 274 | fn | initializeFullMode | (private) | `private func initializeFullMode() async` |
| 290 | fn | checkForProxyUpgrade | (private) | `private func checkForProxyUpgrade() async` |
| 295 | fn | initializeQuotaOnlyMode | (private) | `private func initializeQuotaOnlyMode() async` |
| 305 | fn | initializeRemoteMode | (private) | `private func initializeRemoteMode() async` |
| 333 | fn | setupRemoteAPIClient | (private) | `private func setupRemoteAPIClient(config: Remot...` |
| 341 | fn | reconnectRemote | (internal) | `func reconnectRemote() async` |
| 350 | fn | loadDirectAuthFiles | (internal) | `func loadDirectAuthFiles() async` |
| 356 | fn | refreshQuotasDirectly | (internal) | `func refreshQuotasDirectly() async` |
| 385 | fn | autoSelectMenuBarItems | (private) | `private func autoSelectMenuBarItems()` |
| 419 | fn | syncMenuBarSelection | (internal) | `func syncMenuBarSelection()` |
| 426 | fn | refreshClaudeCodeQuotasInternal | (private) | `private func refreshClaudeCodeQuotasInternal() ...` |
| 447 | fn | refreshCursorQuotasInternal | (private) | `private func refreshCursorQuotasInternal() async` |
| 458 | fn | refreshCodexCLIQuotasInternal | (private) | `private func refreshCodexCLIQuotasInternal() async` |
| 474 | fn | refreshGeminiCLIQuotasInternal | (private) | `private func refreshGeminiCLIQuotasInternal() a...` |
| 492 | fn | refreshGlmQuotasInternal | (private) | `private func refreshGlmQuotasInternal() async` |
| 503 | fn | refreshOpenRouterQuotasInternal | (private) | `private func refreshOpenRouterQuotasInternal() ...` |
| 513 | fn | refreshWarpQuotasInternal | (private) | `private func refreshWarpQuotasInternal() async` |
| 537 | fn | refreshTraeQuotasInternal | (private) | `private func refreshTraeQuotasInternal() async` |
| 547 | fn | refreshKiroQuotasInternal | (private) | `private func refreshKiroQuotasInternal() async` |
| 553 | fn | cleanName | (internal) | `func cleanName(_ name: String) -> String` |
| 601 | fn | startQuotaOnlyAutoRefresh | (private) | `private func startQuotaOnlyAutoRefresh()` |
| 619 | fn | startQuotaAutoRefreshWithoutProxy | (private) | `private func startQuotaAutoRefreshWithoutProxy()` |
| 638 | fn | isWarmupEnabled | (internal) | `func isWarmupEnabled(for provider: AIProvider, ...` |
| 642 | fn | warmupStatus | (internal) | `func warmupStatus(provider: AIProvider, account...` |
| 647 | fn | warmupNextRunDate | (internal) | `func warmupNextRunDate(provider: AIProvider, ac...` |
| 652 | fn | toggleWarmup | (internal) | `func toggleWarmup(for provider: AIProvider, acc...` |
| 661 | fn | setWarmupEnabled | (internal) | `func setWarmupEnabled(_ enabled: Bool, provider...` |
| 673 | fn | nextDailyRunDate | (private) | `private func nextDailyRunDate(minutes: Int, now...` |
| 684 | fn | restartWarmupScheduler | (private) | `private func restartWarmupScheduler()` |
| 717 | fn | runWarmupCycle | (private) | `private func runWarmupCycle() async` |
| 780 | fn | warmupAccount | (private) | `private func warmupAccount(provider: AIProvider...` |
| 825 | fn | warmupAccount | (private) | `private func warmupAccount(     provider: AIPro...` |
| 886 | fn | fetchWarmupModels | (private) | `private func fetchWarmupModels(     provider: A...` |
| 910 | fn | warmupAvailableModels | (internal) | `func warmupAvailableModels(provider: AIProvider...` |
| 923 | fn | warmupAuthInfo | (private) | `private func warmupAuthInfo(provider: AIProvide...` |
| 945 | fn | warmupTargets | (private) | `private func warmupTargets() -> [WarmupAccountKey]` |
| 959 | fn | updateWarmupStatus | (private) | `private func updateWarmupStatus(for key: Warmup...` |
| 988 | fn | startProxy | (internal) | `func startProxy() async` |
| 1032 | fn | stopProxy | (internal) | `func stopProxy()` |
| 1060 | fn | toggleProxy | (internal) | `func toggleProxy() async` |
| 1068 | fn | setupAPIClient | (private) | `private func setupAPIClient()` |
| 1075 | fn | startAutoRefresh | (private) | `private func startAutoRefresh()` |
| 1112 | fn | attemptProxyRecovery | (private) | `private func attemptProxyRecovery() async` |
| 1128 | fn | refreshData | (internal) | `func refreshData() async` |
| 1186 | fn | manualRefresh | (internal) | `func manualRefresh() async` |
| 1197 | fn | refreshAllQuotas | (internal) | `func refreshAllQuotas() async` |
| 1228 | fn | localProxyMigrationBaseURLs | (private) | `private func localProxyMigrationBaseURLs() -> [...` |
| 1254 | fn | refreshQuotasUnified | (internal) | `func refreshQuotasUnified() async` |
| 1289 | fn | refreshAntigravityQuotasInternal | (private) | `private func refreshAntigravityQuotasInternal()...` |
| 1309 | fn | refreshAntigravityQuotasWithoutDetect | (private) | `private func refreshAntigravityQuotasWithoutDet...` |
| 1326 | fn | isAntigravityAccountActive | (internal) | `func isAntigravityAccountActive(email: String) ...` |
| 1331 | fn | switchAntigravityAccount | (internal) | `func switchAntigravityAccount(email: String) async` |
| 1341 | fn | beginAntigravitySwitch | (internal) | `func beginAntigravitySwitch(accountId: String, ...` |
| 1346 | fn | cancelAntigravitySwitch | (internal) | `func cancelAntigravitySwitch()` |
| 1351 | fn | dismissAntigravitySwitchResult | (internal) | `func dismissAntigravitySwitchResult()` |
| 1354 | fn | refreshOpenAIQuotasInternal | (private) | `private func refreshOpenAIQuotasInternal() async` |
| 1359 | fn | refreshCopilotQuotasInternal | (private) | `private func refreshCopilotQuotasInternal() async` |
| 1364 | fn | refreshQuotaForProvider | (internal) | `func refreshQuotaForProvider(_ provider: AIProv...` |
| 1401 | fn | refreshAutoDetectedProviders | (internal) | `func refreshAutoDetectedProviders() async` |
| 1408 | fn | startOAuth | (internal) | `func startOAuth(for provider: AIProvider, proje...` |
| 1453 | fn | startCopilotAuth | (private) | `private func startCopilotAuth() async` |
| 1470 | fn | startKiroAuth | (private) | `private func startKiroAuth(method: AuthCommand)...` |
| 1510 | fn | pollCopilotAuthCompletion | (private) | `private func pollCopilotAuthCompletion() async` |
| 1527 | fn | pollKiroAuthCompletion | (private) | `private func pollKiroAuthCompletion() async` |
| 1550 | fn | pollOAuthStatus | (private) | `private func pollOAuthStatus(state: String, pro...` |
| 1578 | fn | cancelOAuth | (internal) | `func cancelOAuth()` |
| 1582 | fn | deleteAuthFile | (internal) | `func deleteAuthFile(_ file: AuthFile) async` |
| 1618 | fn | toggleAuthFileDisabled | (internal) | `func toggleAuthFileDisabled(_ file: AuthFile) a...` |
| 1649 | fn | pruneMenuBarItems | (private) | `private func pruneMenuBarItems()` |
| 1685 | fn | importVertexServiceAccount | (internal) | `func importVertexServiceAccount(url: URL) async` |
| 1709 | fn | fetchAPIKeys | (internal) | `func fetchAPIKeys() async` |
| 1719 | fn | addAPIKey | (internal) | `func addAPIKey(_ key: String) async` |
| 1731 | fn | updateAPIKey | (internal) | `func updateAPIKey(old: String, new: String) async` |
| 1743 | fn | deleteAPIKey | (internal) | `func deleteAPIKey(_ key: String) async` |
| 1756 | fn | checkAccountStatusChanges | (private) | `private func checkAccountStatusChanges()` |
| 1777 | fn | checkQuotaNotifications | (internal) | `func checkQuotaNotifications()` |
| 1809 | fn | scanIDEsWithConsent | (internal) | `func scanIDEsWithConsent(options: IDEScanOption...` |
| 1879 | fn | savePersistedIDEQuotas | (private) | `private func savePersistedIDEQuotas()` |
| 1902 | fn | loadPersistedIDEQuotas | (private) | `private func loadPersistedIDEQuotas()` |
| 1964 | fn | shortenAccountKey | (private) | `private func shortenAccountKey(_ key: String) -...` |
| 1976 | struct | OAuthState | (internal) | `struct OAuthState` |

## Memory Markers

### 🟢 `NOTE` (line 282)

> checkForProxyUpgrade() is now called inside startProxy()

### 🟢 `NOTE` (line 355)

> Cursor and Trae are NOT auto-refreshed - user must use "Scan for IDEs" (issue #29)

### 🟢 `NOTE` (line 363)

> Cursor and Trae removed from auto-refresh to address privacy concerns (issue #29)

### 🟢 `NOTE` (line 1207)

> Cursor and Trae removed from auto-refresh (issue #29)

### 🟢 `NOTE` (line 1253)

> Cursor and Trae require explicit user scan (issue #29)

### 🟢 `NOTE` (line 1263)

> Cursor and Trae removed - require explicit scan (issue #29)

### 🟢 `NOTE` (line 1319)

> Don't call detectActiveAccount() here - already set by switch operation

