//
//  PopularCollectionViewCell.swift
//  Native Movie List
//
//  Created by Darindra R on 02/06/21.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var popularImage: UIImageView!
    @IBOutlet weak var popularTitle: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    static let identifier = "popularCell"
    private let imageLoader = ImageLoader()

    var popularMovie: Movie? {
        didSet {
            if let popularMovie = popularMovie {
                imageLoader.loadImage(with: popularMovie.poster) { [weak self] in
                    guard let self = self else { return }
                    self.popularImage.image = self.imageLoader.image
                    self.popularTitle.text = popularMovie.title
                    self.popularTitle.alpha = 1
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForReuse() {
        popularTitle.alpha = 0
        popularImage.image = nil
        loadingIndicator.startAnimating()
    }

    static func nib() -> UINib {
        return UINib(nibName: "PopularCollectionViewCell", bundle: nil)
    }

}

fileprivate extension PopularCollectionViewCell {
    func setup() {
        popularImage.layer.cornerRadius = 15
    }
}
