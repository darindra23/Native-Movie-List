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
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieRating: NSLayoutConstraint!

    static let identifier = "MoviesReusableCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        return UINib(nibName: "MoviesReusableCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
