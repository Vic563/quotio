# Outline

[← Back to MODULE](MODULE.md) | [← Back to INDEX](../../INDEX.md)

Symbol maps for 4 large files in this module.

## Quotio/Models/AgentModels.swift (727 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 321 | fn | normalizeProvider | (internal) |
| 340 | fn | inferredProvider | (internal) |
| 515 | fn | isSupported | (internal) |
| 522 | fn | extractFromModelName | (internal) |
| 538 | fn | encoded | (internal) |
| 556 | method | init | (internal) |
| 575 | method | init | (internal) |
| 643 | fn | success | (internal) |
| 669 | fn | failure | (internal) |

## Quotio/Models/CustomProviderModels.swift (556 lines)

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
| 455 | fn | generateGeminiCompatibilityYAML | (private) |
| 483 | fn | generateCodexCompatibilityYAML | (private) |
| 500 | fn | generateGlmCompatibilityYAML | (private) |
| 516 | fn | toYAMLSections | (internal) |

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

## Quotio/Models/Models.swift (649 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 345 | fn | hash | (internal) |
| 536 | method | init | (internal) |
| 553 | mod | extension Int | (internal) |
| 599 | fn | validate | (internal) |
| 639 | fn | sanitize | (internal) |

