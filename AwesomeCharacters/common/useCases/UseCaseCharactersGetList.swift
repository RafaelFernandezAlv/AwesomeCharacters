//
//  UseCaseCharactersGetList.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

protocol UseCaseCharactersGetList {
    func firstPage() async throws -> [CharacterBO]?
    func nextPage() async throws -> [CharacterBO]?
}

extension UseCaseCharacters {
    final class GetList: UseCaseCharactersGetList {
        lazy var repository: CharactersRepositoryActions = CharactersRepository()
        var page: Int = 0
        
        func firstPage() async throws -> [CharacterBO]? {
            return try await execute(page: page)
        }
        
        func nextPage() async throws -> [CharacterBO]? {
            page += 1
            return try await execute(page: page)
        }
        
        private func execute(page: Int) async throws -> [CharacterBO]? {
            return try await repository.getList(page: page)
        }
            
    }
}
