//
//  AppError.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

enum AppError: Error {
    case invalidURL
    case invalidStatusCode(code: Int)
    case invalidResponse
}
