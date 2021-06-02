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
    @IBOutlet weak var popularRating: UILabel!

    static let identifier = "popularCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
