//
//  ListCharacterViewController.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import UIKit
import NVActivityIndicatorView
import Combine

@MainActor
final class ListCharacterViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var viewError: UIView!
    @IBOutlet weak var btnRetry: UIButton!
    
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var lbEmpty: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    lazy var presenter: ListCharactersPresenterActions = ListCharactersPresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func actionRetry(_ sender: Any) {
        presenter.requestFirst()
    }
    
}

@MainActor
extension ListCharacterViewController: ListCharactersPresenterDelegate {
    func itemLoaded(startIndex: Int, numItems: Int) {
        if startIndex == 0 {
            tableView.reloadData()
            if numItems > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
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
        self.title = L10n.Title.list
        
        navigationController?.styleDefault()
        view.styleBackground()
        activityIndicator.styleDefault()
        searchBar.styleDefault()
        
        btnRetry.setTitle(L10n.retry, for: .normal)
        searchBar.placeholder = L10n.Search.placeholder
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
            self.viewEmpty.alpha = 1
        }
    }
    
    func hideEmptyResult() {
        UIView.animate(withDuration: 0.3) {
            self.viewEmpty.alpha = 0
        }
    }
    
    func showError(text: String) {
        lbError.text = text
        UIView.animate(withDuration: 0.3) {
            self.viewError.alpha = 1
        }
    }
    
    func hideError() {
        UIView.animate(withDuration: 0.3) {
            self.viewError.alpha = 0
        }
    }
    
    func showTable() {
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = 1
        }
    }
    
    func hideTable() {
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = 0
        }
    }
}


@MainActor
extension ListCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let totalRows = presenter.item?.rows.count else { return }
        if indexPath.row >= totalRows - 2 {
            presenter.requestMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.goToDetail(index: indexPath.row)
    }
}

@MainActor
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

@MainActor
extension ListCharacterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchByText(text: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchByText(text: searchBar.text)
        searchBar.resignFirstResponder()
    }
}
