# Outline

[← Back to MODULE](MODULE.md) | [← Back to INDEX](../../INDEX.md)

Symbol maps for 4 large files in this module.

## Quotio/Models/AgentModels.swift (766 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 329 | fn | normalizeProvider | (internal) |
| 351 | fn | inferredProvider | (internal) |
| 554 | fn | isSupported | (internal) |
| 561 | fn | extractFromModelName | (internal) |
| 577 | fn | encoded | (internal) |
| 595 | method | init | (internal) |
| 614 | method | init | (internal) |
| 682 | fn | success | (internal) |
| 708 | fn | failure | (internal) |

## Quotio/Models/CustomProviderModels.swift (566 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 14 | enum | CustomProviderType | (internal) |
| 157 | struct | CustomAPIKeyEntry | (internal) |
| 188 | struct | ModelMapping | (internal) |
| 215 | struct | CustomHeader | (internal) |
| 234 | struct | CustomProvider | (internal) |
| 275 | fn | normalizedPrefix | (internal) |
| 294 | method | init | (internal) |
| 310 | fn | encode | (internal) |
| 328 | fn | validate | (internal) |
| 366 | mod | extension CustomProvider | (internal) |
| 382 | fn | toYAMLBlock | (internal) |
| 396 | fn | generateOpenAICompatibilityYAML | (private) |
| 426 | fn | generateClaudeCompatibilityYAML | (private) |
| 465 | fn | generateGeminiCompatibilityYAML | (private) |
| 493 | fn | generateCodexCompatibilityYAML | (private) |
| 510 | fn | generateGlmCompatibilityYAML | (private) |
| 526 | fn | toYAMLSections | (internal) |

## Quotio/Models/MenuBarSettings.swift (632 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 13 | mod | extension String | (internal) |
| 17 | fn | masked | (internal) |
| 38 | fn | masked | (internal) |
| 46 | struct | MenuBarQuotaItem | (internal) |
| 70 | enum | AppearanceMode | (internal) |
| 97 | class | AppearanceManager | (internal) |
| 112 | method | init | (private) |
| 119 | fn | applyAppearance | (internal) |
| 134 | enum | MenuBarColorMode | (internal) |
| 151 | enum | QuotaDisplayMode | (internal) |
| 165 | fn | displayValue | (internal) |
| 183 | enum | QuotaDisplayStyle | (internal) |
| 210 | enum | RefreshCadence | (internal) |
| 253 | enum | TotalUsageMode | (internal) |
| 270 | enum | ModelAggregationMode | (internal) |
| 286 | mod | extension MenuBarSettingsManager | (internal) |
| 334 | fn | calculateTotalUsagePercent | (internal) |
| 359 | fn | aggregateModelPercentages | (internal) |
| 376 | class | RefreshSettingsManager | (internal) |
| 394 | method | init | (private) |
| 404 | struct | MenuBarQuotaDisplayItem | (internal) |
| 423 | class | MenuBarSettingsManager | (internal) |
| 515 | method | init | (private) |
| 553 | fn | saveSelectedItems | (private) |
| 559 | fn | loadSelectedItems | (private) |
| 567 | fn | addItem | (internal) |
| 581 | fn | removeItem | (internal) |
| 587 | fn | isSelected | (internal) |
| 592 | fn | toggleItem | (internal) |
| 602 | fn | pruneInvalidItems | (internal) |
| 606 | fn | autoSelectNewAccounts | (internal) |
| 621 | fn | enforceMaxItems | (private) |
| 628 | fn | clampedMenuBarMax | (private) |

## Quotio/Models/Models.swift (665 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 361 | fn | hash | (internal) |
| 552 | method | init | (internal) |
| 569 | mod | extension Int | (internal) |
| 615 | fn | validate | (internal) |
| 655 | fn | sanitize | (internal) |

