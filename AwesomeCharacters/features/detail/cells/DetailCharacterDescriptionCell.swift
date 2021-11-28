//
//  DetailCharacterDescriptionCell.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 28/11/21.
//

import UIKit

class DetailCharacterDescriptionCell: UITableViewCell {
    static let cellIdentifier = "DetailCharacterDescriptionCellIdentifier"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet private var lbText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(text: String) {
        lbText.text = text
    }
    
}
