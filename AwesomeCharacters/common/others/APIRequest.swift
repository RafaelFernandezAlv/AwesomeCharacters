//
//  APIRequest.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import Foundation

final class APIRequest {
    static let shared = APIRequest()
    private init() { }
    
    func doRequest<T: Codable>(mode: APIRequest.Mode) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: try mode.getRequest())
        if let response = response as? HTTPURLResponse {
            if 200...299 ~= response.statusCode {
                return try JSONDecoder().decode(T.self, from: data)
            } else {
                throw AppError.invalidStatusCode(code: response.statusCode)
            }
        } else {
            throw AppError.invalidResponse
        }
    }
}

extension APIRequest {
    enum Mode {
        case list(page: Int, text: String?)
        case detail(Int)
        
        func getRequest() throws -> URLRequest {
            var components: URLComponents
            switch self {
            case .list(let page, let text):
                components = try Constants.WS.listCharacters(page: page, text: text).toUrlComponents()
            case .detail(let id):
                components = try Constants.WS.detailCharacter(id: id).toUrlComponents()
            }
            return try makeRequest(components: components)
        }
        
        private func makeRequest(components: URLComponents) throws -> URLRequest {
            var components = components
            let tsValue = "\(Int(Date().timeIntervalSince1970))"
            components.queryItems = (components.queryItems ?? []) + [
                URLQueryItem(name: Constants.WS.Key.apikey, value: Constants.WS.Key.Value.publicKey),
                URLQueryItem(name: Constants.WS.Key.ts, value: tsValue),
                URLQueryItem(name: Constants.WS.Key.hash, value: Constants.WS.Key.Value.hash(ts: tsValue)),
            ]
            
            guard let url = components.url else { throw AppError.invalidURL }
            return URLRequest(url: url, timeoutInterval: Constants.WS.timeOut)
        }
    }
}
