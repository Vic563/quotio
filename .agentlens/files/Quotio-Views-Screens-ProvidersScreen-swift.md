# Quotio/Views/Screens/ProvidersScreen.swift

[← Back to Module](../modules/Quotio-Views-Screens/MODULE.md) | [← Back to INDEX](../INDEX.md)

## Overview

- **Lines:** 1229
- **Language:** Swift
- **Symbols:** 30
- **Public symbols:** 0

## Symbol Table

| Line | Kind | Name | Visibility | Signature |
| ---- | ---- | ---- | ---------- | --------- |
| 16 | struct | ProvidersScreen | (internal) | `struct ProvidersScreen` |
| 496 | fn | handleAddProvider | (private) | `private func handleAddProvider(_ provider: AIPr...` |
| 530 | fn | deleteAccount | (private) | `private func deleteAccount(_ account: AccountRo...` |
| 588 | fn | toggleAccountDisabled | (private) | `private func toggleAccountDisabled(_ account: A...` |
| 598 | fn | handleEditGlmAccount | (private) | `private func handleEditGlmAccount(_ account: Ac...` |
| 606 | fn | handleEditWarpAccount | (private) | `private func handleEditWarpAccount(_ account: A...` |
| 614 | fn | handleEditKimiAccount | (private) | `private func handleEditKimiAccount(_ account: A...` |
| 621 | fn | handleEditOpenRouterAccount | (private) | `private func handleEditOpenRouterAccount(_ acco...` |
| 628 | fn | handleEditKilocodeAccount | (private) | `private func handleEditKilocodeAccount(_ accoun...` |
| 635 | fn | syncCustomProvidersToConfig | (private) | `private func syncCustomProvidersToConfig()` |
| 645 | struct | CustomProviderRow | (internal) | `struct CustomProviderRow` |
| 746 | struct | MenuBarBadge | (internal) | `struct MenuBarBadge` |
| 769 | class | TooltipWindow | (private) | `class TooltipWindow` |
| 781 | method | init | (private) | `private init()` |
| 811 | fn | show | (internal) | `func show(text: String, near view: NSView)` |
| 840 | fn | hide | (internal) | `func hide()` |
| 846 | class | TooltipTrackingView | (private) | `class TooltipTrackingView` |
| 848 | fn | updateTrackingAreas | (internal) | `override func updateTrackingAreas()` |
| 859 | fn | mouseEntered | (internal) | `override func mouseEntered(with event: NSEvent)` |
| 863 | fn | mouseExited | (internal) | `override func mouseExited(with event: NSEvent)` |
| 867 | fn | hitTest | (internal) | `override func hitTest(_ point: NSPoint) -> NSView?` |
| 873 | struct | NativeTooltipView | (private) | `struct NativeTooltipView` |
| 875 | fn | makeNSView | (internal) | `func makeNSView(context: Context) -> TooltipTra...` |
| 881 | fn | updateNSView | (internal) | `func updateNSView(_ nsView: TooltipTrackingView...` |
| 887 | mod | extension View | (private) | - |
| 888 | fn | nativeTooltip | (internal) | `func nativeTooltip(_ text: String) -> some View` |
| 895 | struct | MenuBarHintView | (internal) | `struct MenuBarHintView` |
| 910 | struct | OAuthSheet | (internal) | `struct OAuthSheet` |
| 1036 | struct | OAuthStatusView | (private) | `struct OAuthStatusView` |
| 1208 | enum | CustomProviderSheetMode | (internal) | `enum CustomProviderSheetMode` |

## Memory Markers

### 🟢 `NOTE` (line 72)

> GLM uses API key auth via CustomProviderService, so skip it here

