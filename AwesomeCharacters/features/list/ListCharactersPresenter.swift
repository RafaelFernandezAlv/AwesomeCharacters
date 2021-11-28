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
    func showError(text: String)
    func hideError()
    func showLoader()
    func hideLoader()
    func registerCells()
}

@MainActor
protocol ListCharactersPresenterActions {
    func viewDidLoad()
    func requestFirst()
    func requestMore()
    var item: ListCharacterVO? { get }
}

@MainActor
final class ListCharactersPresenter {
    unowned var delegate: ListCharactersPresenterDelegate
    var item: ListCharacterVO?
    fileprivate var isLoadingMore = false
    fileprivate var currentTask: Task<(), Never>?
    
    lazy var useCaseGetList: UseCaseCharactersGetList = UseCaseCharacters.GetList()
    
    init(delegate: ListCharactersPresenterDelegate) {
        self.delegate = delegate
    }
    
    fileprivate func loadFirst() async {
        delegate.hideEmptyResult()
        delegate.hideError()
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
            if !Task.isCancelled {
                delegate.showError(text: error.normalizeError())
            }
        }
        delegate.hideLoader()
    }
    
    fileprivate func loadNext() async {
        delegate.showLoader()
        do {
            if let item = item, let result = try await useCaseGetList.nextPage() {
                let startIndex = item.itemsBO.count
                item.appendItems(items: result)
                delegate.itemLoaded(startIndex: startIndex, numItems: result.count)
            }
        } catch let error {
            if !Task.isCancelled {
                delegate.showError(text: error.normalizeError())
            }
        }
        delegate.hideLoader()
    }
    
    fileprivate func cancelTask() {
        currentTask?.cancel()
        currentTask = nil
        isLoadingMore = false
    }
}

extension ListCharactersPresenter: ListCharactersPresenterActions {
    func viewDidLoad() {
        delegate.registerCells()
        delegate.loadUI()
        requestFirst()
    }
    
    func requestMore() {
        guard !isLoadingMore else { return }
        currentTask = Task {
            isLoadingMore = true
            await loadNext()
            isLoadingMore = false
        }
    }
    
    func requestFirst() {
        currentTask?.cancel()
        currentTask = Task {
            await loadFirst()
        }
    }
}
