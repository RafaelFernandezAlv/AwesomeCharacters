//
//  ListCharactersPresenter.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

@MainActor
protocol ListCharactersPresenterDelegate: AnyObject {
    func itemLoaded(_ item: ListCharacterVO)
    func loadUI()
    func showEmptyResult(text: String)
    func hideEmptyResult()
    func showLoader()
    func hideLoader()
    func registerCells()
}

protocol ListCharactersPresenterActions {
    @MainActor func viewDidLoad()
    var item: ListCharacterVO? { get }
}

final class ListCharactersPresenter {
    unowned var delegate: ListCharactersPresenterDelegate
    var item: ListCharacterVO?
    
    lazy var useCaseGetList: UseCaseCharactersGetList = UseCaseCharacters.GetList()
    
    init(delegate: ListCharactersPresenterDelegate) {
        self.delegate = delegate
    }
    
    @MainActor
    fileprivate func loadData() async throws -> ListCharacterVO? {
        if let result = try await useCaseGetList.execute() {
            return ListCharacterVO(items: result)
        } else {
            return nil
        }
    }
}

extension ListCharactersPresenter: ListCharactersPresenterActions {
    @MainActor
    func viewDidLoad() {
        delegate.registerCells()
        delegate.loadUI()
        Task {
            delegate.hideEmptyResult()
            delegate.showLoader()
            do {
                if let item = try await loadData() {
                    self.item = item
                    delegate.itemLoaded(item)
                } else {
                    delegate.showEmptyResult(text: L10n.noResults)
                }
            } catch let error {
                delegate.showEmptyResult(text: error.normalizeError())
            }
            delegate.hideLoader()
        }
    }
}
