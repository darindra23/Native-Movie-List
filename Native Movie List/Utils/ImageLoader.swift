//
//  ImageLoader.swift
//  Native Movie List
//
//  Created by Darindra R on 04/07/21.
//

import Foundation
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

final class ImageLoader {
    var imageCache = _imageCache

    var image: UIImage?

    func loadImage(with url: URL, completion: @escaping () -> ()) {
        let urlString = url.absoluteString

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            completion()
            return
        }

        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }

            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }

                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.image = image
                    completion()
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
