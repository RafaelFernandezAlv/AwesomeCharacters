//
//  ResponseDTO.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation


// MARK: - Welcome
struct ResponseDTO<T: Codable>: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass<T>?
}

// MARK: - DataClass
struct DataClass<T: Codable>: Codable {
    let offset, limit, total, count: Int?
    let results: T?
}
