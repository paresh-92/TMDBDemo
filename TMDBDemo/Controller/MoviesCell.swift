//
//  MoviesCell.swift
//  TMDBDemo
//
//  Created by Paresh Thakkar on 14/07/21.
//

import UIKit
import Cosmos
class MoviesCell: UITableViewCell {
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var view1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
