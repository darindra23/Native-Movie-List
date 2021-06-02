//
//  MoviesCell.swift
//  Native Movie List
//
//  Created by Darindra R on 02/06/21.
//

import UIKit

class MoviesCell: UITableViewCell {
    @IBOutlet weak var nowPlayingImage: UIImageView!
    @IBOutlet weak var nowPlayingTitle: UILabel!
    @IBOutlet weak var popularCollection: UICollectionView!
    @IBOutlet weak var upcomingTable: UITableView!

    static let identifier = "moviesCell"

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

}

fileprivate extension MoviesCell {
    func setup() {
        setupCollection()
        setupTable()

        nowPlayingImage.layer.cornerRadius = 15
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

