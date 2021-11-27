//
//  CharactersRepository.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

protocol CharactersRepositoryActions {
    func getList() async throws -> [CharacterBO]?
}

final class CharactersRepository {
    
}

extension CharactersRepository: CharactersRepositoryActions {
    func getList() async throws -> [CharacterBO]? {
        let result: ResponseDTO<[CharacterDTO]> = try await APIRequest.shared.doRequest(mode: .list)
        return result.data?.results?.compactMap {
            $0.toBO()
        }
    }
}
