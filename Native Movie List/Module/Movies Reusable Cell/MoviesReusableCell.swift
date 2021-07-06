//
//  MoviesReusableCell.swift
//  Native Movie List
//
//  Created by Darindra R on 15/06/21.
//

import UIKit

class MoviesReusableCell: UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieRatingImage: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!


    static let identifier = "MoviesReusableCell"
    private let imageLoader = ImageLoader()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.moviePoster.layer.cornerRadius = 5
    }

    func configure(with model: Movie?) {
        guard let model = model else { return }
        imageLoader.loadImage(with: model.poster) { [weak self] in
            guard let self = self else { return }
            self.setupUI(with: model)
        }

    }

    static func nib() -> UINib {
        return UINib(nibName: "MoviesReusableCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        self.movieTitle.alpha = 0
        self.movieOverview.alpha = 0
        self.movieReleaseDate.alpha = 0
        self.movieRating.alpha = 0
        self.movieRatingImage.alpha = 0
        self.moviePoster.image = nil
        self.loadingIndicator.startAnimating()
    }

}

fileprivate extension MoviesReusableCell {
    func setupUI(with model: Movie) {
        self.movieTitle.text = model.title
        self.movieTitle.alpha = 1

        self.movieOverview.text = model.overview
        self.movieOverview.alpha = 1

        self.movieReleaseDate.text = model.releaseDate
        self.movieReleaseDate.alpha = 1

        self.movieRating.text = "\(model.voteAverage)"
        self.movieRating.alpha = 1
        self.movieRatingImage.alpha = 1

        self.moviePoster.image = self.imageLoader.image
        self.loadingIndicator.stopAnimating()
    }
}
