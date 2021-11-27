//
//  CharactersRepository.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

protocol CharactersRepositoryActions {
    func getList(page: Int) async throws -> [CharacterBO]?
}

final class CharactersRepository {
    
}

extension CharactersRepository: CharactersRepositoryActions {
    func getList(page: Int) async throws -> [CharacterBO]? {
        let result: ResponseDTO<[CharacterDTO]> = try await APIRequest.shared.doRequest(mode: .list(page: page))
        return result.data?.results?.compactMap {
            $0.toBO()
        }
    }
}
