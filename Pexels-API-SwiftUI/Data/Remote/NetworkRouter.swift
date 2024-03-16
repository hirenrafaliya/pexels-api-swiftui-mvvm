//
//  NetworkRouter.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 15/03/24.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

final class NetworkRouter {
    
    func buildRequest(url: String, method: HttpMethod, headers: [String: String]? = nil, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        
        var updatedHeaders = headers ?? [:]
        updatedHeaders["Authorization"] = PEXELS_API_KEY
        request.allHTTPHeaderFields = updatedHeaders
        request.httpBody = body
        return request
    }
    
    func executeRequest<T: Decodable>(request: URLRequest) async -> Result<T, ResponseError> {
        NetworkLogger.logRequest(request: request)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            NetworkLogger.logResponse(data: data, response: response)
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                switch httpResponse.statusCode {
                case 200...299:
                    let decodedData = try decoder.decode(T.self, from: data)
                    return .success(decodedData)
                default:
                    return .failure(.invalidResponse)
                }
            } else {
                let decodedData = try decoder.decode(T.self, from: data)
                return .success(decodedData)
            }
        } catch {
            return .failure(.requestFailure(error))
        }
    }
    
   
}
