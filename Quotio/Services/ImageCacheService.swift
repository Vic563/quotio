//
//  ImageCacheService.swift
//  Quotio
//
//  NSCache-based image caching with memory pressure eviction.
//  Reduces memory usage by caching resized images and responding to system memory warnings.
//

import AppKit
import Foundation

private final class ImageCacheController: @unchecked Sendable {
    let cache: NSCache<NSString, NSImage>

    init(cache: NSCache<NSString, NSImage>) {
        self.cache = cache
    }

    func clear() {
        cache.removeAllObjects()
    }

    func setCountLimit(_ limit: Int) {
        cache.countLimit = limit
    }
}

/// Thread-safe image cache with automatic memory pressure eviction
final class ImageCacheService: NSObject, @unchecked Sendable {
    static let shared = ImageCacheService()

    private let cache: NSCache<NSString, NSImage>
    private let cacheController: ImageCacheController
    private let notificationCenter: NotificationCenter
    private let imageLoader: (String) -> NSImage?

    /// Retained memory pressure source to prevent deallocation
    private var memoryPressureSource: DispatchSourceMemoryPressure?

    init(
        cache: NSCache<NSString, NSImage> = NSCache<NSString, NSImage>(),
        notificationCenter: NotificationCenter = .default,
        imageLoader: @escaping (String) -> NSImage? = { NSImage(named: $0) }
    ) {
        self.cache = cache
        self.cacheController = ImageCacheController(cache: cache)
        self.notificationCenter = notificationCenter
        self.imageLoader = imageLoader
        super.init()
        cache.countLimit = 50
        cache.totalCostLimit = 10 * 1024 * 1024
        setupMemoryPressureHandler()
    }

    deinit {
        memoryPressureSource?.cancel()
        memoryPressureSource = nil
    }

    // MARK: - Public API

    /// Get a cached image or load and cache it
    /// - Parameters:
    ///   - name: Asset catalog image name
    ///   - size: Target size for the image (images are cached at this size)
    /// - Returns: The image, or nil if not found
    func image(named name: String, size: CGFloat? = nil) -> NSImage? {
        let cacheKey = makeCacheKey(name: name, size: size)

        // Check cache first
        if let cached = cache.object(forKey: cacheKey as NSString) {
            return cached
        }

        // Load from asset catalog
        guard let original = imageLoader(name) else {
            return nil
        }

        // Resize if needed and cache
        let imageToCache: NSImage
        if let targetSize = size, targetSize < min(original.size.width, original.size.height) {
            imageToCache = resized(image: original, to: targetSize)
        } else {
            imageToCache = original
        }

        // Estimate cost (bytes)
        let cost = estimateCost(for: imageToCache)
        cache.setObject(imageToCache, forKey: cacheKey as NSString, cost: cost)

        return imageToCache
    }

    /// Clear all cached images (called on memory pressure)
    func clearCache() {
        cache.removeAllObjects()
    }

    var cacheCountLimit: Int {
        cache.countLimit
    }

    // MARK: - Private Helpers

    private func makeCacheKey(name: String, size: CGFloat?) -> String {
        if let size = size {
            return "\(name)_\(Int(size))"
        }
        return name
    }

    private func resized(image: NSImage, to targetSize: CGFloat) -> NSImage {
        let newSize = NSSize(width: targetSize, height: targetSize)
        let newImage = NSImage(size: newSize)

        newImage.lockFocus()
        image.draw(
            in: NSRect(origin: .zero, size: newSize),
            from: NSRect(origin: .zero, size: image.size),
            operation: .copy,
            fraction: 1.0
        )
        newImage.unlockFocus()

        return newImage
    }

    private func estimateCost(for image: NSImage) -> Int {
        // Estimate: width * height * 4 bytes per pixel (RGBA)
        let width = Int(image.size.width)
        let height = Int(image.size.height)
        return width * height * 4
    }

    private func setupMemoryPressureHandler() {
        let source = DispatchSource.makeMemoryPressureSource(eventMask: [.warning, .critical], queue: .main)
        let cacheController = self.cacheController
        source.setEventHandler {
            cacheController.clear()
        }
        memoryPressureSource = source
        source.resume()

        notificationCenter.addObserver(
            self,
            selector: #selector(handleDidResignActive),
            name: NSApplication.didResignActiveNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(handleDidBecomeActive),
            name: NSApplication.didBecomeActiveNotification,
            object: nil
        )
    }

    @objc private func handleDidResignActive() {
        cacheController.setCountLimit(20)
    }

    @objc private func handleDidBecomeActive() {
        cacheController.setCountLimit(50)
    }
}
