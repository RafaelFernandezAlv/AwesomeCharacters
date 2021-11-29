//
//  DetailCharacterLinkCell.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 28/11/21.
//

import UIKit

class DetailCharacterLinkCell: UITableViewCell {
    static let cellIdentifier = "DetailCharacterLinkCellIdentifier"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet private var btnLink: UIButton!
    private var action: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadUI()
    }
    
    private func loadUI() {
        btnLink.styleDefault()
    }

    override var selectionStyle: UITableViewCell.SelectionStyle { get { .none } set { } }
    override func setSelected(_ selected: Bool, animated: Bool) { }
    
    func loadCell(text: String, action: @escaping () -> Void) {
        btnLink.setTitle(text, for: .normal)
        self.action = action
    }
    
    //MARK: - Actions
    @IBAction func actionGoLink(_ sender: Any) {
        action?()
    }
    
}
