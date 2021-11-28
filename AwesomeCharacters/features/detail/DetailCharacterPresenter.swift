//
//  DetailCharacterPresenter.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 28/11/21.
//

import Foundation
import UIKit
import SafariServices

@MainActor
protocol DetailCharacterPresenterDelegate: UIViewController {
    func itemLoaded()
    func loadUI(title: String)
    func registerCells()
}

@MainActor
protocol DetailCharacterPresenterActions {
    init(delegate: DetailCharacterPresenterDelegate, itemBO: CharacterBO)
    var item: DetailCharacterVO? { get }
    func viewDidLoad()
    func gotToWeb(url: URL)
}

@MainActor
final class DetailCharacterPresenter {
    unowned var delegate: DetailCharacterPresenterDelegate
    
    var item: DetailCharacterVO?
    var itemBO: CharacterBO
    
    init(delegate: DetailCharacterPresenterDelegate, itemBO: CharacterBO) {
        self.delegate = delegate
        self.itemBO = itemBO
    }
}


extension DetailCharacterPresenter: DetailCharacterPresenterActions {
    
    func viewDidLoad() {
        delegate.registerCells()
        delegate.loadUI(title: itemBO.name)
        item = DetailCharacterVO(item: itemBO)
        delegate.itemLoaded()
    }
    
    func gotToWeb(url: URL) {
        let webView = SFSafariViewController(url: url)
        delegate.present(webView, animated: true, completion: nil)
    }
}
