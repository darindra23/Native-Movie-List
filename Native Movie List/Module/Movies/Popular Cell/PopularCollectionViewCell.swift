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

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForReuse() {
        popularTitle.alpha = 0
        popularImage.image = nil
        loadingIndicator.startAnimating()
    }

    func configure(with model: Movie?) {
        guard let model = model else { return }
        imageLoader.loadImage(with: model.poster) { [weak self] in
            guard let self = self else { return }
            self.popularImage.image = self.imageLoader.image
            self.popularTitle.text = model.title
            self.popularTitle.alpha = 1
            self.loadingIndicator.stopAnimating()
        }
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
