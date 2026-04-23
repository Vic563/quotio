# Quotio/Services/AgentConfigurationService.swift

[← Back to Module](../modules/root/MODULE.md) | [← Back to INDEX](../INDEX.md)

## Overview

- **Lines:** 2148
- **Language:** Swift
- **Symbols:** 52
- **Public symbols:** 0

## Symbol Table

| Line | Kind | Name | Visibility | Signature |
| ---- | ---- | ---- | ---------- | --------- |
| 8 | class | AgentConfigurationService | (internal) | `actor AgentConfigurationService` |
| 56 | fn | readConfiguration | (internal) | `func readConfiguration(agent: CLIAgent) -> Save...` |
| 77 | fn | migrateProxyCredentialsIfNeeded | (internal) | `func migrateProxyCredentialsIfNeeded(validAPIKe...` |
| 111 | fn | listBackups | (internal) | `func listBackups(agent: CLIAgent) -> [BackupFile]` |
| 140 | fn | restoreFromBackup | (internal) | `func restoreFromBackup(_ backup: BackupFile) th...` |
| 158 | fn | readClaudeCodeConfig | (private) | `private func readClaudeCodeConfig() -> SavedAge...` |
| 220 | fn | readCodexConfig | (private) | `private func readCodexConfig() -> SavedAgentCon...` |
| 280 | fn | readCopilotCLIConfig | (private) | `private func readCopilotCLIConfig() -> SavedAge...` |
| 349 | fn | readGeminiCLIConfig | (private) | `private func readGeminiCLIConfig() -> SavedAgen...` |
| 391 | fn | readAmpConfig | (private) | `private func readAmpConfig() -> SavedAgentConfig?` |
| 418 | fn | readOpenCodeConfig | (private) | `private func readOpenCodeConfig() -> SavedAgent...` |
| 463 | fn | readFactoryDroidConfig | (private) | `private func readFactoryDroidConfig() -> SavedA...` |
| 506 | fn | migrateClaudeCodeProxyCredentialIfNeeded | (private) | `private func migrateClaudeCodeProxyCredentialIf...` |
| 527 | fn | migrateCodexProxyCredentialIfNeeded | (private) | `private func migrateCodexProxyCredentialIfNeede...` |
| 549 | fn | migrateAmpProxyCredentialIfNeeded | (private) | `private func migrateAmpProxyCredentialIfNeeded(...` |
| 573 | fn | migrateOpenCodeProxyCredentialIfNeeded | (private) | `private func migrateOpenCodeProxyCredentialIfNe...` |
| 598 | fn | migrateFactoryDroidProxyCredentialIfNeeded | (private) | `private func migrateFactoryDroidProxyCredential...` |
| 632 | fn | extractTOMLValue | (private) | `private func extractTOMLValue(from line: String...` |
| 643 | fn | extractExportValue | (private) | `private func extractExportValue(from line: Stri...` |
| 655 | fn | extractCodexBaseURL | (private) | `private func extractCodexBaseURL(from configCon...` |
| 665 | fn | normalizeBaseURL | (private) | `private func normalizeBaseURL(_ rawValue: Strin...` |
| 671 | fn | writeJSONWithBackupIfChanged | (private) | `@discardableResult   private func writeJSONWith...` |
| 697 | fn | escapeTOMLString | (private) | `private func escapeTOMLString(_ value: String) ...` |
| 725 | fn | buildManagedCodexTOML | (private) | `private func buildManagedCodexTOML(model: Strin...` |
| 745 | fn | parseTOMLSectionName | (private) | `private func parseTOMLSectionName(from line: St...` |
| 763 | fn | isCodexManagedTopLevelKey | (private) | `private func isCodexManagedTopLevelKey(_ line: ...` |
| 772 | fn | splitManagedCodexConfig | (private) | `private func splitManagedCodexConfig(_ managedC...` |
| 780 | fn | extractManagedCodexBanner | (private) | `private func extractManagedCodexBanner(from man...` |
| 789 | fn | filterExistingCodexLines | (private) | `private func filterExistingCodexLines(existingC...` |
| 830 | fn | composeMergedCodexConfig | (private) | `private func composeMergedCodexConfig(filteredL...` |
| 901 | fn | mergeCodexConfig | (private) | `private func mergeCodexConfig(existingContent: ...` |
| 908 | fn | generateConfiguration | (internal) | `func generateConfiguration(     agent: CLIAgent...` |
| 950 | fn | generateDefaultConfiguration | (private) | `private func generateDefaultConfiguration(agent...` |
| 968 | fn | generateClaudeCodeDefaultConfig | (private) | `private func generateClaudeCodeDefaultConfig(mo...` |
| 1058 | fn | generateCodexDefaultConfig | (private) | `private func generateCodexDefaultConfig(mode: C...` |
| 1105 | fn | generateGeminiCLIDefaultConfig | (private) | `private func generateGeminiCLIDefaultConfig(mod...` |
| 1133 | fn | generateCopilotCLIDefaultConfig | (private) | `private func generateCopilotCLIDefaultConfig(mo...` |
| 1164 | fn | generateAmpDefaultConfig | (private) | `private func generateAmpDefaultConfig(mode: Con...` |
| 1210 | fn | generateOpenCodeDefaultConfig | (private) | `private func generateOpenCodeDefaultConfig(mode...` |
| 1259 | fn | generateFactoryDroidDefaultConfig | (private) | `private func generateFactoryDroidDefaultConfig(...` |
| 1324 | fn | generateClaudeCodeConfig | (private) | `private func generateClaudeCodeConfig(config: A...` |
| 1410 | fn | mergeClaudeConfig | (private) | `private func mergeClaudeConfig(existingPath: St...` |
| 1427 | fn | generateClaudeResult | (private) | `private func generateClaudeResult(     configPa...` |
| 1502 | fn | generateCodexConfig | (private) | `private func generateCodexConfig(config: AgentC...` |
| 1587 | fn | generateGeminiCLIConfig | (private) | `private func generateGeminiCLIConfig(config: Ag...` |
| 1630 | fn | generateCopilotCLIConfig | (private) | `private func generateCopilotCLIConfig(config: A...` |
| 1721 | fn | generateAmpConfig | (private) | `private func generateAmpConfig(config: AgentCon...` |
| 1804 | fn | generateOpenCodeConfig | (private) | `private func generateOpenCodeConfig(config: Age...` |
| 1896 | fn | buildOpenCodeModelConfig | (private) | `private func buildOpenCodeModelConfig(for model...` |
| 1948 | fn | generateFactoryDroidConfig | (private) | `private func generateFactoryDroidConfig(config:...` |
| 2018 | fn | fetchAvailableModels | (internal) | `func fetchAvailableModels(config: AgentConfigur...` |
| 2073 | fn | testConnection | (internal) | `func testConnection(agent: CLIAgent, config: Ag...` |

