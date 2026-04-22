# Quotio/Views/Screens/ProvidersScreen.swift

[← Back to Module](../modules/Quotio-Views-Screens/MODULE.md) | [← Back to INDEX](../INDEX.md)

## Overview

- **Lines:** 1118
- **Language:** Swift
- **Symbols:** 28
- **Public symbols:** 0

## Symbol Table

| Line | Kind | Name | Visibility | Signature |
| ---- | ---- | ---- | ---------- | --------- |
| 16 | struct | ProvidersScreen | (internal) | `struct ProvidersScreen` |
| 424 | fn | handleAddProvider | (private) | `private func handleAddProvider(_ provider: AIPr...` |
| 452 | fn | deleteAccount | (private) | `private func deleteAccount(_ account: AccountRo...` |
| 491 | fn | toggleAccountDisabled | (private) | `private func toggleAccountDisabled(_ account: A...` |
| 501 | fn | handleEditGlmAccount | (private) | `private func handleEditGlmAccount(_ account: Ac...` |
| 509 | fn | handleEditWarpAccount | (private) | `private func handleEditWarpAccount(_ account: A...` |
| 517 | fn | handleEditKimiAccount | (private) | `private func handleEditKimiAccount(_ account: A...` |
| 524 | fn | syncCustomProvidersToConfig | (private) | `private func syncCustomProvidersToConfig()` |
| 534 | struct | CustomProviderRow | (internal) | `struct CustomProviderRow` |
| 635 | struct | MenuBarBadge | (internal) | `struct MenuBarBadge` |
| 658 | class | TooltipWindow | (private) | `class TooltipWindow` |
| 670 | method | init | (private) | `private init()` |
| 700 | fn | show | (internal) | `func show(text: String, near view: NSView)` |
| 729 | fn | hide | (internal) | `func hide()` |
| 735 | class | TooltipTrackingView | (private) | `class TooltipTrackingView` |
| 737 | fn | updateTrackingAreas | (internal) | `override func updateTrackingAreas()` |
| 748 | fn | mouseEntered | (internal) | `override func mouseEntered(with event: NSEvent)` |
| 752 | fn | mouseExited | (internal) | `override func mouseExited(with event: NSEvent)` |
| 756 | fn | hitTest | (internal) | `override func hitTest(_ point: NSPoint) -> NSView?` |
| 762 | struct | NativeTooltipView | (private) | `struct NativeTooltipView` |
| 764 | fn | makeNSView | (internal) | `func makeNSView(context: Context) -> TooltipTra...` |
| 770 | fn | updateNSView | (internal) | `func updateNSView(_ nsView: TooltipTrackingView...` |
| 776 | mod | extension View | (private) | - |
| 777 | fn | nativeTooltip | (internal) | `func nativeTooltip(_ text: String) -> some View` |
| 784 | struct | MenuBarHintView | (internal) | `struct MenuBarHintView` |
| 799 | struct | OAuthSheet | (internal) | `struct OAuthSheet` |
| 925 | struct | OAuthStatusView | (private) | `struct OAuthStatusView` |
| 1097 | enum | CustomProviderSheetMode | (internal) | `enum CustomProviderSheetMode` |

## Memory Markers

### 🟢 `NOTE` (line 68)

> GLM uses API key auth via CustomProviderService, so skip it here

