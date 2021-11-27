//
//  ListCharactersPresenter.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

@MainActor
protocol ListCharactersPresenterDelegate: AnyObject {
    func itemLoaded(startIndex: Int, numItems: Int)
    func loadUI()
    func showEmptyResult(text: String)
    func hideEmptyResult()
    func showLoader()
    func hideLoader()
    func registerCells()
}

protocol ListCharactersPresenterActions {
    @MainActor func viewDidLoad()
    @MainActor func requestMore()
    var item: ListCharacterVO? { get }
}

final class ListCharactersPresenter {
    unowned var delegate: ListCharactersPresenterDelegate
    var item: ListCharacterVO?
    fileprivate var isLoading = false
    
    lazy var useCaseGetList: UseCaseCharactersGetList = UseCaseCharacters.GetList()
    
    init(delegate: ListCharactersPresenterDelegate) {
        self.delegate = delegate
    }
    
    @MainActor
    fileprivate func loadFirst() async {
        delegate.hideEmptyResult()
        delegate.showLoader()
        do {
            if let result = try await useCaseGetList.firstPage() {
                let vo = ListCharacterVO(items: result)
                self.item = vo
                delegate.itemLoaded(startIndex: 0, numItems: result.count)
            } else {
                delegate.showEmptyResult(text: L10n.noResults)
            }
        } catch let error {
            delegate.showEmptyResult(text: error.normalizeError())
        }
        delegate.hideLoader()
    }
    
    @MainActor
    fileprivate func loadNext() async {
        delegate.showLoader()
        do {
            if let item = item, let result = try await useCaseGetList.nextPage() {
                let startIndex = item.itemsBO.count
                item.appendItems(items: result)
                delegate.itemLoaded(startIndex: startIndex, numItems: result.count)
            } else {
                delegate.showEmptyResult(text: L10n.noResults)
            }
        } catch let error {
            delegate.showEmptyResult(text: error.normalizeError())
        }
        delegate.hideLoader()
    }
}

extension ListCharactersPresenter: ListCharactersPresenterActions {
    @MainActor
    func viewDidLoad() {
        delegate.registerCells()
        delegate.loadUI()
        Task {
            await loadFirst()
        }
    }
    
    func requestMore() {
        Task {
            guard !isLoading else { return }
            isLoading = true
            await loadNext()
            isLoading = false
        }
    }
}
