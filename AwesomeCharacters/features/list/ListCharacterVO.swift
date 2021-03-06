//
//  ListCharacterVO.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation


final class ListCharacterVO {
    private(set) var itemsBO: [CharacterBO]
    
    lazy var rows: [Rows] = generateRows()
    
    init(items: [CharacterBO]) {
        self.itemsBO = items
    }
    
    private func generateRows() -> [Rows] {
        return itemsBO.map { Rows.list(CharacterVO(item: $0)) }
    }
    
    func appendItems(items: [CharacterBO]) {
        itemsBO.append(contentsOf: items)
        self.rows = generateRows()
    }
    
}

extension ListCharacterVO {
    final class CharacterVO {
        let itemBO: CharacterBO
        
        init(item: CharacterBO) {
            self.itemBO = item
        }
        
        var imageURL: URL? { itemBO.thumbnail }
        var title: String { itemBO.name }
        var description: String { itemBO.description ?? L10n.empty}
    }
}

extension ListCharacterVO {
    enum Rows {
        case list(CharacterVO)
    }
}
