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
    
    @IBOutlet private weak var lbTitle: UILabel!
    @IBOutlet private weak var lbDescription: UILabel!
    @IBOutlet private weak var imgBackground: UIImageView!
    @IBOutlet weak var viewBottomBackground: UIView!
    
    private var character: ListCharacterVO.CharacterVO?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBottomBackground.backgroundColor = .black
        viewBottomBackground.alpha = 0.7
        
        lbTitle.textColor = .white
        lbDescription.textColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        character = nil
        imgBackground.image = nil
    }
    
    func loadCell(item: ListCharacterVO.CharacterVO) {
        if let imageURL = item.imageURL {
            imgBackground.kf.setImage(with: imageURL, options: [.transition(.fade(0.25))]) { [weak self] result in
                switch result {
                case .failure:
                    self?.imgBackground.image = Asset.placeholderEmpty.image
                default: break
                }
            }
        } else {
            imgBackground.image = Asset.placeholderEmpty.image
        }
        lbTitle.text = item.title
        lbDescription.text = item.description
    }
    
}
