//
//  FeedCell.swift
//  PhotoSharingAppFB
//
//  Created by Cihan on 24.01.2024.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var imageViewUpload: UIImageView!
    @IBOutlet weak var labelCommet: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
