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
    
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    lazy var presenter: ListCharactersPresenterActions = ListCharactersPresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension ListCharacterViewController: ListCharacterView { }

extension ListCharacterViewController: ListCharactersPresenterDelegate {
    func itemLoaded(_ item: ListCharacterVO) {
        
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
}
