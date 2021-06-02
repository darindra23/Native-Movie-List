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

    static let identifier = "upcomingCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
