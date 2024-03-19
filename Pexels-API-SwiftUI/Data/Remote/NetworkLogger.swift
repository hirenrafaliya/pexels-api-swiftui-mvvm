//
//  NetoworkLogger.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation

class NetworkLogger {
    
    static func logRequest(request: URLRequest) {
        print("-- -- -- -- --")
        print("\(request.httpMethod ?? "N/A"): \(request.url?.absoluteString ?? "N/A")")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
    }
    
    static func logResponse(data: Data, response: URLResponse) {
        print("-- -- -- -- --")
        let httpResponse = response as? HTTPURLResponse
//        let bodyString = getJson(from: data)
        print("\(httpResponse?.statusCode ?? -1): \(response.url?.absoluteString ?? "N/A")")
//        print("Headers: \(httpResponse?.allHeaderFields ?? [:])")
//        print("Body: \n\(bodyString)")
    }
    
    // Returns formatted JSON String
    static func getJson(from data: Data) -> String {
        var jsonStr = "Unknown error!"
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            jsonStr = String(decoding: jsonData, as: UTF8.self)
        } else {
            jsonStr = "Malformed JSON"
        }
        return jsonStr
    }
}
