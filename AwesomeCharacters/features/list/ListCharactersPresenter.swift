//
//  ListCharactersPresenter.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

protocol ListCharactersPresenterDelegate: AnyObject {
    func itemLoaded(_ item: ListCharacterVO)
    func loadUI()
    func showLoader()
    func hideLoader()
}

@MainActor
protocol ListCharactersPresenterActions {
    func viewDidLoad()
}

final class ListCharactersPresenter {
    unowned var delegate: ListCharactersPresenterDelegate
    
    init(delegate: ListCharactersPresenterDelegate) {
        self.delegate = delegate
    }
    
    fileprivate func loadData() async {
        await Task.sleep(3 * 1_000_000_000) // Wait three seconds

    }
}

extension ListCharactersPresenter: ListCharactersPresenterActions {
    func viewDidLoad() {
        delegate.loadUI()
        Task {
            delegate.showLoader()
            await loadData()
            delegate.hideLoader()
        }
    }
}
