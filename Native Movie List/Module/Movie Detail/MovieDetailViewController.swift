//
//  MovieDetailViewController.swift
//  Native Movie List
//
//  Created by Darindra R on 02/06/21.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var addToWatchList: UIButton!
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var trailer: YTPlayerView!
    @IBOutlet weak var overviewCountries: UILabel!
    @IBOutlet weak var overviewLanguages: UILabel!
    @IBOutlet weak var overviewGenres: UILabel!
    @IBOutlet weak var overviewBudget: UILabel!
    @IBOutlet weak var overviewRevenue: UILabel!
    @IBOutlet weak var overviewSynopsis: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var readMoreButton: UIButton!

    static let identifier = "MovieDetailViewController"
    private let viewModel = MovieDetailViewModel()
    private let imageLoader = ImageLoader()
    var movieId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchMovie(movieId: movieId!)
    }

    @IBAction func addWatchList(_ sender: Any) {

    }

    @IBAction func synopsisReadMore(_ sender: UIButton) {
        self.overviewSynopsis.numberOfLines = 0
        self.readMoreButton.isHidden = true
    }
}

extension MovieDetailViewController {
    func initialSetup() {
        self.trailer.delegate = self
        self.navigationItem.largeTitleDisplayMode = .never
    }

    func fetchMovie(movieId: Int) {
        viewModel.fetchDetailMovie(movieId: movieId) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard let movieData = self.viewModel.data else { return }

                self.setupView(with: movieData)
            }
        }
    }

    func setupView(with data: Movie) {
        self.scrollView.isScrollEnabled = true
        self.movieTitle.text = data.title
        self.releaseDate.text = Utils.getDate(data.releaseDate!)
        self.status.text = "\(data.status?.uppercased() ?? "")"
        self.ratings.text = "\(data.voteAverage ?? 0)"
        self.reviews.text = "\(data.reviews ?? 0)"
        self.language.text = "\(data.language?.uppercased() ?? "")"
        self.runtime.text = "\(data.runtime ?? 0) Min"
        self.overviewCountries.text = viewModel.getCountries()
        self.overviewLanguages.text = viewModel.getLanguages()
        self.overviewGenres.text = viewModel.getGenres()
        self.overviewBudget.text = String(data.budget!).formatToDollar()
        self.overviewRevenue.text = String(data.revenue!).formatToDollar()
        self.overviewSynopsis.text = data.overview

        imageLoader.loadImage(with: data.poster) { [weak self] in
            guard let self = self else { return }
            self.poster.image = self.imageLoader.image
            self.loading.stopAnimating()
        }

        guard let video = data.videos?.results else { return }

        if !video.isEmpty {
            self.trailer.load(withVideoId: video[0].key!)
        }
    }
}

extension MovieDetailViewController: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        UIColor.systemGray6
    }

    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.center = playerView.center
        loading.startAnimating()
        return loading
    }
}
