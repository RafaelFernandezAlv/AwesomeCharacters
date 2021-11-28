//
//  ListCharactersPresenter.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation
import Combine

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
    func showTable()
    func hideTable()
    func registerCells()
}

@MainActor
protocol ListCharactersPresenterActions {
    func viewDidLoad()
    func requestFirst()
    func requestMore()
    func searchByText(text: String?)
    var item: ListCharacterVO? { get }
}

@MainActor
final class ListCharactersPresenter {
    unowned var delegate: ListCharactersPresenterDelegate
    var item: ListCharacterVO?
    fileprivate var isLoadingMore = false
    fileprivate var currentTask: Task<(), Never>?
    
    var searchText = PassthroughSubject<String?, Never>()
    private var lastSeatchText: String?
    var subscription: Set<AnyCancellable> = []
    
    lazy var useCaseGetList: UseCaseCharactersGetList = UseCaseCharacters.GetList()
    
    init(delegate: ListCharactersPresenterDelegate) {
        self.delegate = delegate
        configureSearch()
    }
    
    private func loadFirst() async {
        delegate.hideEmptyResult()
        delegate.hideError()
        delegate.showLoader()
        do {
            if let result = try await useCaseGetList.firstPage(text: lastSeatchText) {
                let vo = ListCharacterVO(items: result)
                self.item = vo
                delegate.showTable()
                delegate.itemLoaded(startIndex: 0, numItems: result.count)
            } else {
                delegate.hideTable()
                delegate.showEmptyResult(text: L10n.noResults)
            }
        } catch let error {
            if !Task.isCancelled {
                delegate.hideTable()
                delegate.showError(text: error.normalizeError())
            }
        }
        delegate.hideLoader()
    }
    
    private func loadNext() async {
        guard !useCaseGetList.finishList else { return }
        delegate.showLoader()
        do {
            if let item = item, let result = try await useCaseGetList.nextPage(text: lastSeatchText) {
                let startIndex = item.itemsBO.count
                item.appendItems(items: result)
                delegate.showTable()
                delegate.itemLoaded(startIndex: startIndex, numItems: result.count)
            }
        } catch let error {
            if !Task.isCancelled {
                delegate.hideTable()
                delegate.showError(text: error.normalizeError())
            }
        }
        delegate.hideLoader()
    }
    
    private func cancelTask() {
        currentTask?.cancel()
        currentTask = nil
        isLoadingMore = false
    }
    
    private func configureSearch() {
        searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { _ in } receiveValue: { [weak self] value in
                self?.lastSeatchText = value
                self?.requestFirst()
            }
            .store(in: &subscription)

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
    
    func searchByText(text: String?) {
        searchText.send(text)
    }
}
