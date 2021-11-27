//
//  CharacterMapper.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

extension CharacterDTO {
    func toBO() -> CharacterBO? {
        return CharacterBO(dto: self)
    }
}

extension CharacterBO {
    init?(dto item: CharacterDTO) {
        guard let id = item.id,
              let description = item.resultDescription,
              let thumbnailPath = item.thumbnail?.path,
              let thumbnailExtension = item.thumbnail?.thumbnailExtension,
              let thumbnail = URL(string: "\(thumbnailPath).\(thumbnailExtension)"),
              let comicsTitle = item.comics?.items?.compactMap({ $0.name }),
              let seriesTitle = item.series?.items?.compactMap({ $0.name }),
              let storiesTitle = item.stories?.items?.compactMap({ $0.name }),
              let eventsTitle = item.events?.items?.compactMap({ $0.name }),
              let urls = item.urls?.compactMap({ item -> CharacterBO.URLType? in
                  if let type = item.type, let urlStr = item.url, let url = URL(string: urlStr) {
                      switch type {
                      case .comic:
                          return CharacterBO.URLType.comic(url: url)
                      case .wiki:
                          return CharacterBO.URLType.wiki(url: url)
                      case .detail:
                          return CharacterBO.URLType.detail(url: url)
                      }
                  }
                  return nil
              }) else { return nil}
        
        self.id = id
        self.description = description
        self.thumbnail = thumbnail
        self.comicsTitle = comicsTitle
        self.seriesTitle = seriesTitle
        self.storiesTitle = storiesTitle
        self.eventsTitle = eventsTitle
        self.urls = urls
    }
}
