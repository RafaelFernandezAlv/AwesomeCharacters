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

extension Error {
    func normalizeError() -> String {
        if let error = self as? AppError {
            switch error {
            case .invalidURL:
                return L10n.Error.invalidURL
            case .invalidStatusCode(let code):
                return L10n.Error.invalidStatusCode(code)
            case .invalidResponse:
                return L10n.Error.invalidResponse
            }
        } else if (self as NSError).domain == NSURLErrorDomain && (self as NSError).code == NSURLErrorNotConnectedToInternet {
            return L10n.Error.noInternetConnection
        } else if (self as NSError).domain == NSURLErrorDomain && (self as NSError).code == NSURLErrorTimedOut {
            return L10n.Error.timeOut
        } else {
            return L10n.Error.unknown
        }
    }
}
