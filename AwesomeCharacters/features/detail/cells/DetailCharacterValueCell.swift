//
//  DetailCharacterValueCell.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 28/11/21.
//

import UIKit

class DetailCharacterValueCell: UITableViewCell {
    static let cellIdentifier = "DetailCharacterValueCellIdentifier"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet private var lbText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadUI()
    }
    
    private func loadUI() {
        lbText.styleBlack()
        lbText.styleRegularBody()
    }

    override var selectionStyle: UITableViewCell.SelectionStyle { get { .none } set { } }
    override func setSelected(_ selected: Bool, animated: Bool) { }
    
    func loadCell(text: String) {
        lbText.text = " • \(text)"
    }
}
