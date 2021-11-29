//
//  DetailCharacterImageCell.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 28/11/21.
//

import UIKit
import Kingfisher
import AZImagePreview

class DetailCharacterImageCell: UITableViewCell {
    static let cellIdentifier = "DetailCharacterImageCellIdentifier"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet private var imgMain: UIImageView!
    @IBOutlet weak var imgBlur: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var selectionStyle: UITableViewCell.SelectionStyle { get { .none } set { } }
    override func setSelected(_ selected: Bool, animated: Bool) { }
    
    func loadCell(url: URL, delegate: AZPreviewImageViewDelegate) {
        imgMain.delegate = delegate
        imgMain.kf.setImage(with: url, options: [.transition(.fade(0.25))]) { [weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.global().async {
                    if let image = result.image.blurEffect() {
                        DispatchQueue.main.async {
                            self?.imgBlur.image = image
                        }
                    }
                }
            default: break
            }
        }
    }
}
