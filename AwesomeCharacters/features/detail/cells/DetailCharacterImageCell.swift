//
//  DetailCharacterImageCell.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 28/11/21.
//

import UIKit
import Kingfisher

class DetailCharacterImageCell: UITableViewCell {
    static let cellIdentifier = "DetailCharacterImageCellIdentifier"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet private var imgMain: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(url: URL) {
        imgMain.kf.setImage(with: url)
    }
    
}
