//
//  UseCaseCharactersGetList.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

protocol UseCaseCharactersGetList {
    func execute() async throws -> [CharacterBO]?
}

extension UseCaseCharacters {
    final class GetList: UseCaseCharactersGetList {
        lazy var repository: CharactersRepositoryActions = CharactersRepository()
        
        func execute() async throws -> [CharacterBO]? {
            return try await repository.getList()
        }
    }
}
