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
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    static let identifier = "upcomingCell"
    private let imageLoader = ImageLoader()

    var upcomingMovie: Movie? {
        didSet {
            if let upcomingMovie = upcomingMovie {
                imageLoader.loadImage(with: upcomingMovie.poster) { [weak self] in
                    guard let self = self else { return }
                    self.upcomingImage.image = self.imageLoader.image
                    self.upcomingTitle.text = upcomingMovie.title
                    self.upcomingTitle.alpha = 1
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        self.upcomingTitle.alpha = 0
        self.upcomingImage.image = nil
        self.loadingIndicator.startAnimating()
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
