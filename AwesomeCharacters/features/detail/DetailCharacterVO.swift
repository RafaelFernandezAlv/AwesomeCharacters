//
//  DetailCharacterVO.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 28/11/21.
//

import Foundation

final class DetailCharacterVO {
    let itemBO: CharacterBO
    
    lazy var rows: [Rows] = generateRows()
    
    init(item: CharacterBO) {
        self.itemBO = item
    }
    
    private func generateRows() -> [Rows] {
        var rows = [Rows]()
        if let thumbnail = itemBO.thumbnail {
            rows.append(.image(thumbnail))
        }
        
        rows.append(.title(itemBO.name))
        
        if let description = itemBO.description {
            rows.append(.description(description))
        }
        
        if itemBO.comicsTitle.count > 0 {
            rows.append(.separator)
            rows.append(.header(L10n.Title.comic(itemBO.comicsTitle.count)))
            rows.append(contentsOf: itemBO.comicsTitle.map({ .value($0) }))
        }
        
        if itemBO.seriesTitle.count > 0 {
            rows.append(.separator)
            rows.append(.header(L10n.Title.series(itemBO.seriesTitle.count)))
            rows.append(contentsOf: itemBO.seriesTitle.map({ .value($0) }))
        }
        
        if itemBO.storiesTitle.count > 0 {
            rows.append(.separator)
            rows.append(.header(L10n.Title.stories(itemBO.storiesTitle.count)))
            rows.append(contentsOf: itemBO.storiesTitle.map({ .value($0) }))
        }
        
        if itemBO.eventsTitle.count > 0 {
            rows.append(.separator)
            rows.append(.header(L10n.Title.events(itemBO.eventsTitle.count)))
            rows.append(contentsOf: itemBO.eventsTitle.map({ .value($0) }))
        }
        
        if itemBO.urls.count > 0 {
            rows.append(.separator)
            rows.append(.header(L10n.Title.links))
            rows.append(contentsOf: itemBO.urls.map({ item -> Rows in
                switch item {
                case .comic(let url):
                    return .link(L10n.Link.comic, url)
                case .detail(let url):
                    return .link(L10n.Link.detail, url)
                case .wiki(let url):
                    return .link(L10n.Link.wiki, url)
                }
            }))
        }
        
        return rows
    }
    
}

extension DetailCharacterVO {
    enum Rows {
        case description(String)
        case header(String)
        case image(URL)
        case separator
        case link(String, URL)
        case title(String)
        case value(String)
    }
}
