//
//  DetailCharacterViewController.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 28/11/21.
//

import UIKit
import AZImagePreview

final class DetailCharacterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: DetailCharacterPresenterActions!

    required init(itemBO: CharacterBO) {
        super.init(nibName: nil, bundle: nil)
        presenter = DetailCharacterPresenter(delegate: self, itemBO: itemBO) //Mandatory instanciate here
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

}

@MainActor
extension DetailCharacterViewController: DetailCharacterPresenterDelegate {
    func itemLoaded() {
        tableView.reloadData()
    }
    
    func loadUI(title: String) {
        self.title = title
        tableView.separatorStyle = .none
    }
    
    func registerCells() {
        tableView.register(DetailCharacterDescriptionCell.nib, forCellReuseIdentifier: DetailCharacterDescriptionCell.cellIdentifier)
        
        tableView.register(DetailCharacterHeaderCell.nib, forCellReuseIdentifier: DetailCharacterHeaderCell.cellIdentifier)
        tableView.register(DetailCharacterValueCell.nib, forCellReuseIdentifier: DetailCharacterValueCell.cellIdentifier)
        tableView.register(DetailCharacterTitleCell.nib, forCellReuseIdentifier: DetailCharacterTitleCell.cellIdentifier)
        tableView.register(DetailCharacterLinkCell.nib, forCellReuseIdentifier: DetailCharacterLinkCell.cellIdentifier)
        tableView.register(DetailCharacterSeparatorCell.nib, forCellReuseIdentifier: DetailCharacterSeparatorCell.cellIdentifier)
        tableView.register(DetailCharacterImageCell.nib, forCellReuseIdentifier: DetailCharacterImageCell.cellIdentifier)
        
    }
}

extension DetailCharacterViewController: UITableViewDelegate { }

@MainActor
extension DetailCharacterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.item?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = presenter.item?.rows else { return UITableViewCell() }
        
        switch items[indexPath.row] {
        case .description(let text):
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCharacterDescriptionCell.cellIdentifier) as? DetailCharacterDescriptionCell {
                cell.loadCell(text: text)
                return cell
            }
        case .header(let text):
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCharacterHeaderCell.cellIdentifier) as? DetailCharacterHeaderCell {
                cell.loadCell(text: text)
                return cell
            }
        case .image(let url):
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCharacterImageCell.cellIdentifier) as? DetailCharacterImageCell {
                cell.loadCell(url: url, delegate: self)
                return cell
            }
        case .separator:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCharacterSeparatorCell.cellIdentifier) as? DetailCharacterSeparatorCell {
                return cell
            }
        case .link(let text, let url):
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCharacterLinkCell.cellIdentifier) as? DetailCharacterLinkCell {
                cell.loadCell(text: text) { [weak self] in
                    self?.presenter.gotToWeb(url: url)
                }
                return cell
            }
        case .title(let text):
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCharacterTitleCell.cellIdentifier) as? DetailCharacterTitleCell {
                cell.loadCell(text: text)
                return cell
            }
        case .value(let text):
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCharacterValueCell.cellIdentifier) as? DetailCharacterValueCell {
                cell.loadCell(text: text)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension DetailCharacterViewController: AZPreviewImageViewDelegate {
    func previewImageViewInRespectTo(_ previewImageView: UIImageView) -> UIView? {
        return view
    }
    
    func previewImageView(_ previewImageView: UIImageView, requestImagePreviewWithPreseneter presenter: AZImagePresenterViewController) {
        present(presenter, animated: false, completion: nil)
    }
}
