import AppKit
import XCTest
@testable import Quotio

final class ImageCacheServiceTests: XCTestCase {
    @MainActor
    func testImageLoaderResultIsCachedUntilCacheCleared() {
        let notificationCenter = NotificationCenter()
        var loadCount = 0
        let service = ImageCacheService(
            notificationCenter: notificationCenter,
            imageLoader: { _ in
                loadCount += 1
                return Self.makeImage()
            }
        )

        let firstImage = service.image(named: "provider-icon", size: 16)
        let secondImage = service.image(named: "provider-icon", size: 16)

        XCTAssertNotNil(firstImage)
        XCTAssertTrue(firstImage === secondImage)
        XCTAssertEqual(loadCount, 1)

        service.clearCache()

        let thirdImage = service.image(named: "provider-icon", size: 16)

        XCTAssertNotNil(thirdImage)
        XCTAssertFalse(firstImage === thirdImage)
        XCTAssertEqual(loadCount, 2)
    }

    @MainActor
    func testAppActivityNotificationsAdjustCacheLimit() {
        let notificationCenter = NotificationCenter()
        let service = ImageCacheService(
            notificationCenter: notificationCenter,
            imageLoader: { _ in Self.makeImage() }
        )

        XCTAssertEqual(service.cacheCountLimit, 50)

        notificationCenter.post(name: NSApplication.didResignActiveNotification, object: nil)
        XCTAssertEqual(service.cacheCountLimit, 20)

        notificationCenter.post(name: NSApplication.didBecomeActiveNotification, object: nil)
        XCTAssertEqual(service.cacheCountLimit, 50)
    }

    private static func makeImage(size: NSSize = NSSize(width: 32, height: 32)) -> NSImage {
        let image = NSImage(size: size)
        image.lockFocus()
        NSColor.systemBlue.setFill()
        NSBezierPath(rect: NSRect(origin: .zero, size: size)).fill()
        image.unlockFocus()
        return image
    }
}
