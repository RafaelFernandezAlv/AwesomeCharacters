//
//  UseCaseCharactersGetList.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

protocol UseCaseCharactersGetList {
    func firstPage(text: String?) async throws -> [CharacterBO]?
    func nextPage(text: String?) async throws -> [CharacterBO]?
    var finishList: Bool { get }
}

extension UseCaseCharacters {
    final class GetList: UseCaseCharactersGetList {
        lazy var repository: CharactersRepositoryActions = CharactersRepository()
        var page: Int = 0
        var total: Int?
        
        var finishList: Bool {
            if let total = total {
                return ((page + 1) * Constants.WS.offsetList) >= total
            } else {
                return false
            }
        }
        
        func firstPage(text: String?) async throws -> [CharacterBO]? {
            page = 0
            total = nil
            return try await execute(page: page, text: text)
        }
        
        func nextPage(text: String?) async throws -> [CharacterBO]? {
            guard !finishList else { return nil }
            page += 1
            return try await execute(page: page, text: text)
        }
        
        private func execute(page: Int, text: String?) async throws -> [CharacterBO]? {
            let results = try await repository.getList(page: page, text: text)
            total = results.1
            return results.0
        }
            
    }
}
