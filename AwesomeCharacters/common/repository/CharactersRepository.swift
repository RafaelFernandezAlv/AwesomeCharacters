//
//  CharactersRepository.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

protocol CharactersRepositoryActions {
    func getList(page: Int, text: String?) async throws -> ([CharacterBO]?, Int)
}

final class CharactersRepository {
    
}

extension CharactersRepository: CharactersRepositoryActions {
    func getList(page: Int, text: String?) async throws -> ([CharacterBO]?, Int) {
        let result: ResponseDTO<[CharacterDTO]> = try await APIRequest.shared.doRequest(mode: .list(page: page, text: text))
        let items = result.data?.results?.compactMap {
            $0.toBO()
        }
        return (items, result.data?.total ?? 0)
    }
}
