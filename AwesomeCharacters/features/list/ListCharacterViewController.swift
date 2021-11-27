//
//  ListCharacterViewController.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import UIKit

protocol ListCharacterView: UIViewController {
    
}

final class ListCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListCharacterViewController: ListCharacterView {
    
}
