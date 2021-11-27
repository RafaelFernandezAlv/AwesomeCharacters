//
//  ListCharacterViewController.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import UIKit
import NVActivityIndicatorView

protocol ListCharacterView: UIViewController {
    
}

final class ListCharacterViewController: UIViewController {
    
    @IBOutlet weak var lbEmpty: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    lazy var presenter: ListCharactersPresenterActions = ListCharactersPresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
}

extension ListCharacterViewController: ListCharacterView {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let totalRows = presenter.item?.rows.count else { return }
        if indexPath.row >= totalRows - 2 {
            presenter.requestMore()
        }
    }
}

extension ListCharacterViewController: ListCharactersPresenterDelegate {
    func itemLoaded(startIndex: Int, numItems: Int) {
        if startIndex == 0 {
            tableView.reloadData()
        } else {
            var insertIndexPaths: [IndexPath] = []
            for i in startIndex..<(startIndex + numItems) {
                insertIndexPaths.append(IndexPath(row: i, section: 0))
            }
            tableView.insertRows(at: insertIndexPaths, with: .automatic)
        }
    }
    
    func registerCells() {
        tableView.register(ListCharacterViewCell.nib, forCellReuseIdentifier: ListCharacterViewCell.cellIdentifier)
    }
    
    func loadUI() {
        activityIndicator.type = .pacman
        activityIndicator.color = .red
        view.backgroundColor = .white
    }
    
    func showLoader() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.alpha = 1
        }
    }
    
    func hideLoader() {
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.alpha = 0
        } completion: { _ in
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showEmptyResult(text: String) {
        lbEmpty.text = text
        UIView.animate(withDuration: 0.3) {
            self.lbEmpty.alpha = 1
        }
    }
    
    func hideEmptyResult() {
        UIView.animate(withDuration: 0.3) {
            self.lbEmpty.alpha = 0
        }
    }
}


extension ListCharacterViewController: UITableViewDelegate { }

extension ListCharacterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.item?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = presenter.item?.rows else { return UITableViewCell() }
        
        switch items[indexPath.row] {
        case .list(let item):
            if let cell = tableView.dequeueReusableCell(withIdentifier: ListCharacterViewCell.cellIdentifier) as? ListCharacterViewCell {
                cell.loadCell(item: item)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
