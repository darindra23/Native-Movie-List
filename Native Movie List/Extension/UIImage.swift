//
//  UIImage.swift
//  Native Movie List
//
//  Created by Darindra R on 04/07/21.
//

import UIKit


extension UIImageView {
    func loadImage(with url: URL) {
        let urlString = url.absoluteString

        let imageCache: NSCache<AnyObject, AnyObject> = NSCache<AnyObject, AnyObject>()

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

                imageCache.setObject(image, forKey: urlString as AnyObject)
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

