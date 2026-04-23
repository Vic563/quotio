# Outline

[← Back to MODULE](MODULE.md) | [← Back to INDEX](../../INDEX.md)

Symbol maps for 2 large files in this module.

## Quotio/Services/Proxy/CLIProxyManager.swift (2121 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 9 | class | CLIProxyManager | (internal) |
| 243 | method | init | (internal) |
| 284 | fn | restartProxyIfRunning | (private) |
| 302 | fn | updateConfigValue | (private) |
| 322 | fn | updateConfigPort | (private) |
| 326 | fn | updateConfigHost | (private) |
| 330 | fn | ensureApiKeyExistsInConfig | (private) |
| 379 | fn | updateConfigAllowRemote | (internal) |
| 383 | fn | updateConfigLogging | (internal) |
| 391 | fn | updateConfigRoutingStrategy | (internal) |
| 396 | fn | updateConfigProxyURL | (internal) |
| 424 | fn | applyBaseURLWorkaround | (internal) |
| 453 | fn | removeBaseURLWorkaround | (internal) |
| 495 | fn | ensureConfigExists | (private) |
| 529 | fn | syncSecretKeyInConfig | (private) |
| 545 | fn | regenerateManagementKey | (internal) |
| 587 | fn | syncProxyURLInConfig | (private) |
| 604 | fn | syncCustomProvidersToConfig | (private) |
| 616 | fn | syncCustomProvidersAndRestartIfRunning | (internal) |
| 637 | fn | downloadAndInstallBinary | (internal) |
| 698 | fn | fetchLatestRelease | (private) |
| 719 | fn | findCompatibleAsset | (private) |
| 744 | fn | downloadAsset | (private) |
| 763 | fn | extractAndInstall | (private) |
| 825 | fn | findBinaryInDirectory | (private) |
| 858 | fn | start | (internal) |
| 990 | fn | waitForBackendReadiness | (private) |
| 1007 | fn | waitForBridgeReadiness | (private) |
| 1024 | fn | bridgeAcceptsConnections | (private) |
| 1051 | fn | terminateProcessIfNeeded | (private) |
| 1066 | fn | stop | (internal) |
| 1118 | fn | startHealthMonitor | (private) |
| 1132 | fn | stopHealthMonitor | (private) |
| 1137 | fn | performHealthCheck | (private) |
| 1200 | fn | cleanupOrphanProcesses | (private) |
| 1263 | fn | terminateAuthProcess | (internal) |
| 1269 | fn | toggle | (internal) |
| 1277 | fn | copyEndpointToClipboard | (internal) |
| 1282 | fn | revealInFinder | (internal) |
| 1289 | enum | ProxyError | (internal) |
| 1320 | enum | AuthCommand | (internal) |
| 1358 | struct | AuthCommandResult | (internal) |
| 1364 | mod | extension CLIProxyManager | (internal) |
| 1365 | fn | runAuthCommand | (internal) |
| 1397 | fn | appendOutput | (internal) |
| 1401 | fn | tryResume | (internal) |
| 1412 | fn | safeResume | (internal) |
| 1512 | mod | extension CLIProxyManager | (internal) |
| 1542 | fn | checkForUpgrade | (internal) |
| 1593 | fn | saveInstalledVersion | (private) |
| 1601 | fn | fetchAvailableReleases | (internal) |
| 1623 | fn | versionInfo | (internal) |
| 1629 | fn | fetchGitHubRelease | (private) |
| 1651 | fn | findCompatibleAsset | (private) |
| 1684 | fn | performManagedUpgrade | (internal) |
| 1742 | fn | downloadAndInstallVersion | (private) |
| 1789 | fn | startDryRun | (private) |
| 1860 | fn | promote | (private) |
| 1895 | fn | rollback | (internal) |
| 1928 | fn | stopTestProxy | (private) |
| 1957 | fn | stopTestProxySync | (private) |
| 1983 | fn | findUnusedPort | (private) |
| 1993 | fn | isPortInUse | (private) |
| 2012 | fn | createTestConfig | (private) |
| 2040 | fn | cleanupTestConfig | (private) |
| 2048 | fn | isNewerVersion | (private) |
| 2051 | fn | parseVersion | (internal) |
| 2083 | fn | findPreviousVersion | (private) |
| 2096 | fn | migrateToVersionedStorage | (internal) |

## Quotio/Services/Proxy/ProxyBridge.swift (1127 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 22 | struct | FallbackContext | (internal) |
| 96 | class | ProxyBridge | (internal) |
| 158 | method | init | (internal) |
| 167 | fn | configure | (internal) |
| 190 | fn | start | (internal) |
| 230 | fn | stop | (internal) |
| 240 | fn | handleListenerState | (private) |
| 256 | fn | handleNewConnection | (private) |
| 492 | fn | createFallbackContext | (private) |

