//
//  MoviesCell.swift
//  Native Movie List
//
//  Created by Darindra R on 02/06/21.
//

import UIKit

protocol MoviesCellDelegate: AnyObject {
    func navigate(viewController: UIViewController)
}

class MoviesCell: UITableViewCell {
    @IBOutlet weak var nowPlayingImage: UIImageView!
    @IBOutlet weak var nowPlayingTitle: UILabel!
    @IBOutlet weak var popularCollection: UICollectionView!
    @IBOutlet weak var upcomingTable: UITableView!

    static let identifier = "moviesCell"
    let viewModel = MoviesCellViewModel()

    weak var delegate: MoviesCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static func nib() -> UINib {
        return UINib(nibName: "MoviesCell", bundle: nil)
    }

    @IBAction func seeAllButton(_ sender: UIButton) {
        let vc = SeeAllMoviesController(nibName: SeeAllMoviesController.identifier, bundle: nil)

        switch sender.tag {
        case 0:
            vc.title = "Now playing"
        case 1:
            vc.title = "Popular"
        default:
            vc.title = "Upcoming"
        }

        delegate?.navigate(viewController: vc)
    }
}

fileprivate extension MoviesCell {
    func setup() {
        setupCollection()
        setupTable()

        nowPlayingImage.layer.cornerRadius = 15
        viewModel.fetch(from: .nowPlaying, page: 1)

        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            guard let data = self.viewModel.data else { return }
            self.setupNowPlaying(data: data.data[0])
            ImageLoader.shared.loadImage(with: data.data[0].backdrop)
        }
    }

    func setupCollection() {
        popularCollection.dataSource = self
        popularCollection.delegate = self
        popularCollection.register(PopularCollectionViewCell.nib(), forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
    }

    func setupTable() {
        upcomingTable.dataSource = self
        upcomingTable.delegate = self
        upcomingTable.register(UpcomingCell.nib(), forCellReuseIdentifier: UpcomingCell.identifier)
    }

    func setupNowPlaying(data: Movie) {
        nowPlayingTitle.text = data.title
        ImageLoader.shared.bindImage = { [weak self] in
            guard let self = self else { return }
            self.nowPlayingImage.image = ImageLoader.shared.image
        }
    }
}

extension MoviesCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath)
        return cell
    }
}

extension MoviesCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingCell.identifier, for: indexPath)
        return cell
    }
}

