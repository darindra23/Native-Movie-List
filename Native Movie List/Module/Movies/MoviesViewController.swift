//
//  MainViewController.swift
//  Native Movie List
//
//  Created by Darindra R on 25/05/21.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var nowPlayingBackgroundImage: UIImageView!
    @IBOutlet weak var nowPlayingTitle: UILabel!
    @IBOutlet weak var popularCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

private extension MoviesViewController {
    func setup() {
        nowPlayingBackgroundImage.layer.cornerRadius = 15

        popularCollection.dataSource = self
        popularCollection.delegate = self
        popularCollection.register(PopularCollectionViewCell.nib(), forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
    }
}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath)
        return cell
    }
}

