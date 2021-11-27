//
//  CharacterBO.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

struct CharacterBO {
    let id: Int
    let description: String?
    let thumbnail: URL?
    let comicsTitle: [String]
    let seriesTitle: [String]
    let storiesTitle: [String]
    let eventsTitle: [String]
    let urls: [URLType]
    
    enum URLType {
        case detail(url: URL)
        case wiki(url: URL)
        case comic(url: URL)
    }
}
