//
//  ListCharacterViewCell.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import UIKit
import Kingfisher

class ListCharacterViewCell: UITableViewCell {
    static let cellIdentifier = "ListCharacterViewCellIdentifier"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet private weak var imgMain: UIImageView!
    @IBOutlet private weak var lbTitle: UILabel!
    @IBOutlet private weak var lbDescription: UILabel!
    
    private var character: ListCharacterVO.CharacterVO?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        character = nil
    }
    
    func loadCell(item: ListCharacterVO.CharacterVO) {
        if let imageURL = item.imageURL {
            imgMain.kf.setImage(with: imageURL) { [weak self] result in
                switch result {
                case .failure:
                    self?.imgMain.image = Asset.placeholderEmpty.image
                default: break
                }
            }
        } else {
            imgMain.image = Asset.placeholderEmpty.image
        }
        lbTitle.text = item.title
        lbDescription.text = item.description
    }
    
}
