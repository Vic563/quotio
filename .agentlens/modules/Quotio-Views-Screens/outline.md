# Outline

[← Back to MODULE](MODULE.md) | [← Back to INDEX](../../INDEX.md)

Symbol maps for 6 large files in this module.

## Quotio/Views/Screens/DashboardScreen.swift (1013 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 9 | struct | DashboardScreen | (internal) |
| 572 | fn | handleStepAction | (private) |
| 583 | fn | showProviderPicker | (private) |
| 607 | fn | showAgentPicker | (private) |
| 807 | struct | GettingStartedStep | (internal) |
| 816 | struct | GettingStartedStepRow | (internal) |
| 871 | struct | KPICard | (internal) |
| 899 | struct | ProviderChip | (internal) |
| 923 | struct | FlowLayout | (internal) |
| 937 | fn | layout | (private) |
| 965 | struct | QuotaProviderRow | (internal) |

## Quotio/Views/Screens/FallbackScreen.swift (558 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 8 | struct | FallbackScreen | (internal) |
| 113 | fn | loadModelsIfNeeded | (private) |
| 341 | struct | VirtualModelsEmptyState | (internal) |
| 383 | struct | VirtualModelRow | (internal) |
| 504 | struct | FallbackEntryRow | (internal) |

## Quotio/Views/Screens/LogsScreen.swift (557 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 8 | struct | LogsScreen | (internal) |
| 301 | struct | RequestRow | (internal) |
| 491 | fn | attemptOutcomeLabel | (private) |
| 502 | fn | attemptOutcomeColor | (private) |
| 517 | struct | StatItem | (internal) |
| 534 | struct | LogRow | (internal) |

## Quotio/Views/Screens/ProvidersScreen.swift (1118 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 16 | struct | ProvidersScreen | (internal) |
| 424 | fn | handleAddProvider | (private) |
| 452 | fn | deleteAccount | (private) |
| 491 | fn | toggleAccountDisabled | (private) |
| 501 | fn | handleEditGlmAccount | (private) |
| 509 | fn | handleEditWarpAccount | (private) |
| 517 | fn | handleEditKimiAccount | (private) |
| 524 | fn | syncCustomProvidersToConfig | (private) |
| 534 | struct | CustomProviderRow | (internal) |
| 635 | struct | MenuBarBadge | (internal) |
| 658 | class | TooltipWindow | (private) |
| 670 | method | init | (private) |
| 700 | fn | show | (internal) |
| 729 | fn | hide | (internal) |
| 735 | class | TooltipTrackingView | (private) |
| 737 | fn | updateTrackingAreas | (internal) |
| 748 | fn | mouseEntered | (internal) |
| 752 | fn | mouseExited | (internal) |
| 756 | fn | hitTest | (internal) |
| 762 | struct | NativeTooltipView | (private) |
| 764 | fn | makeNSView | (internal) |
| 770 | fn | updateNSView | (internal) |
| 776 | mod | extension View | (private) |
| 777 | fn | nativeTooltip | (internal) |
| 784 | struct | MenuBarHintView | (internal) |
| 799 | struct | OAuthSheet | (internal) |
| 925 | struct | OAuthStatusView | (private) |
| 1097 | enum | CustomProviderSheetMode | (internal) |

## Quotio/Views/Screens/QuotaScreen.swift (1627 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 8 | struct | QuotaScreen | (internal) |
| 37 | fn | accountCount | (private) |
| 54 | fn | lowestQuotaPercent | (private) |
| 213 | struct | QuotaDisplayHelper | (private) |
| 215 | fn | statusColor | (internal) |
| 231 | fn | displayPercent | (internal) |
| 240 | struct | ProviderSegmentButton | (private) |
| 318 | struct | QuotaStatusDot | (private) |
| 337 | struct | ProviderQuotaView | (private) |
| 419 | struct | AccountInfo | (private) |
| 431 | struct | AccountQuotaCardV2 | (private) |
| 843 | fn | standardContentByStyle | (private) |
| 871 | struct | PlanBadgeV2Compact | (private) |
| 925 | struct | PlanBadgeV2 | (private) |
| 980 | struct | SubscriptionBadgeV2 | (private) |
| 1021 | struct | AntigravityDisplayGroup | (private) |
| 1031 | struct | AntigravityGroupRow | (private) |
| 1108 | struct | AntigravityLowestBarLayout | (private) |
| 1127 | fn | displayPercent | (private) |
| 1189 | struct | AntigravityRingLayout | (private) |
| 1201 | fn | displayPercent | (private) |
| 1230 | struct | StandardLowestBarLayout | (private) |
| 1249 | fn | displayPercent | (private) |
| 1322 | struct | StandardRingLayout | (private) |
| 1334 | fn | displayPercent | (private) |
| 1369 | struct | AntigravityModelsDetailSheet | (private) |
| 1438 | struct | ModelDetailCard | (private) |
| 1505 | struct | UsageRowV2 | (private) |
| 1593 | struct | QuotaLoadingView | (private) |

## Quotio/Views/Screens/SettingsScreen.swift (3051 lines)

| Line | Kind | Name | Visibility |
| ---- | ---- | ---- | ---------- |
| 9 | struct | SettingsScreen | (internal) |
| 111 | struct | OperatingModeSection | (internal) |
| 176 | fn | handleModeSelection | (private) |
| 195 | fn | switchToMode | (private) |
| 210 | struct | RemoteServerSection | (internal) |
| 330 | fn | saveRemoteConfig | (private) |
| 338 | fn | reconnect | (private) |
| 353 | struct | UnifiedProxySettingsSection | (internal) |
| 573 | fn | loadConfig | (private) |
| 620 | fn | saveProxyURL | (private) |
| 638 | fn | saveRoutingStrategy | (private) |
| 647 | fn | saveSwitchProject | (private) |
| 656 | fn | saveSwitchPreviewModel | (private) |
| 665 | fn | saveRequestRetry | (private) |
| 674 | fn | saveMaxRetryInterval | (private) |
| 683 | fn | saveLoggingToFile | (private) |
| 692 | fn | saveRequestLog | (private) |
| 701 | fn | saveDebugMode | (private) |
| 714 | struct | LocalProxyServerSection | (internal) |
| 788 | struct | NetworkAccessSection | (internal) |
| 822 | struct | LocalPathsSection | (internal) |
| 846 | struct | PathLabel | (internal) |
| 870 | struct | NotificationSettingsSection | (internal) |
| 940 | struct | QuotaDisplaySettingsSection | (internal) |
| 982 | struct | RefreshCadenceSettingsSection | (internal) |
| 1021 | struct | UpdateSettingsSection | (internal) |
| 1063 | struct | ProxyUpdateSettingsSection | (internal) |
| 1223 | fn | checkForUpdate | (private) |
| 1237 | fn | performUpgrade | (private) |
| 1256 | struct | ProxyVersionManagerSheet | (internal) |
| 1415 | fn | sectionHeader | (private) |
| 1430 | fn | isVersionInstalled | (private) |
| 1434 | fn | refreshInstalledVersions | (private) |
| 1438 | fn | loadReleases | (private) |
| 1452 | fn | installVersion | (private) |
| 1470 | fn | performInstall | (private) |
| 1491 | fn | activateVersion | (private) |
| 1509 | fn | deleteVersion | (private) |
| 1522 | struct | InstalledVersionRow | (private) |
| 1580 | struct | AvailableVersionRow | (private) |
| 1666 | fn | formatDate | (private) |
| 1684 | struct | MenuBarSettingsSection | (internal) |
| 1825 | struct | AppearanceSettingsSection | (internal) |
| 1854 | struct | PrivacySettingsSection | (internal) |
| 1876 | struct | GeneralSettingsTab | (internal) |
| 1915 | struct | AboutTab | (internal) |
| 1942 | struct | AboutScreen | (internal) |
| 2157 | struct | AboutUpdateSection | (internal) |
| 2213 | struct | AboutProxyUpdateSection | (internal) |
| 2366 | fn | checkForUpdate | (private) |
| 2380 | fn | performUpgrade | (private) |
| 2399 | struct | VersionBadge | (internal) |
| 2451 | struct | AboutUpdateCard | (internal) |
| 2542 | struct | AboutProxyUpdateCard | (internal) |
| 2716 | fn | checkForUpdate | (private) |
| 2730 | fn | performUpgrade | (private) |
| 2749 | struct | LinkCard | (internal) |
| 2836 | struct | ManagementKeyRow | (internal) |
| 2930 | struct | LaunchAtLoginToggle | (internal) |
| 2988 | struct | UsageDisplaySettingsSection | (internal) |

