//
//  ImageLoader.swift
//  Native Movie List
//
//  Created by Darindra R on 04/07/21.
//

import Foundation
import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private init() { }

    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        return cache
    }()

    var image: UIImage? {
        didSet {
            self.displayImage?()
        }
    }

    var bindImage: (() -> ())?

    func loadImage(with url: URL) {
        let urlString = url.absoluteString

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }

            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }

                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
