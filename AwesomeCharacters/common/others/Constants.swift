//
//  Constants.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

struct Constants {
    struct WS {
        static let baseURL = "https://gateway.marvel.com"
        private static let listCharacters = "\(baseURL)/v1/public/characters"
        static let offsetList = 20
        static func listCharacters(page: Int, text: String?) -> String {
            var result = "\(listCharacters)?offset=\(offsetList * page)"
            if let text = text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !text.isEmpty {
                result = "\(result)&nameStartsWith=\(text)"
            }
            return result
        }
        static func detailCharacter(id: Int) -> String {
            return "\(listCharacters)/\(id)"
        }
        
        static let timeOut: TimeInterval = 15
        
        struct Key {
            static let apikey = "apikey"
            static let ts = "ts"
            static let hash = "hash"
            
            struct Value {
                static let publicKey = "903774492f66758aa308aca09d8f5cdf"
                private static let privateKey = "9e3fd83fe91c4451fbe7a2741a32c7772d59e0a3"
                static func hash(ts: String) -> String {
                    return "\(ts)\(privateKey)\(publicKey)".md5
                }
            }
        }
    }
}
