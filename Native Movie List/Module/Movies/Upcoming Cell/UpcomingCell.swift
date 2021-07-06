//
//  UpcomingCell.swift
//  Native Movie List
//
//  Created by Darindra R on 02/06/21.
//

import UIKit

class UpcomingCell: UITableViewCell {
    @IBOutlet weak var upcomingImage: UIImageView!
    @IBOutlet weak var upcomingTitle: UILabel!
    @IBOutlet weak var upcomingReleaseDate: UILabel!
    @IBOutlet weak var upcomingOverview: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    static let identifier = "upcomingCell"
    private let imageLoader = ImageLoader()

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        self.upcomingTitle.alpha = 0
        self.upcomingOverview.alpha = 0
        self.upcomingReleaseDate.alpha = 0
        self.upcomingImage.image = nil
        self.loadingIndicator.startAnimating()
    }

    func configure(with model: Movie?) {
        guard let model = model else { return }
        imageLoader.loadImage(with: model.poster) { [weak self] in
            guard let self = self else { return }

            self.upcomingTitle.text = model.title
            self.upcomingTitle.alpha = 1

            self.upcomingReleaseDate.text = model.releaseDate
            self.upcomingReleaseDate.alpha = 1

            self.upcomingOverview.text = model.overview
            self.upcomingOverview.alpha = 1

            self.upcomingImage.image = self.imageLoader.image
            self.loadingIndicator.stopAnimating()
        }
    }

    static func nib() -> UINib {
        return UINib(nibName: "UpcomingCell", bundle: nil)
    }
}

fileprivate extension UpcomingCell {
    func setup() {
        upcomingImage.layer.cornerRadius = 15
    }
}
