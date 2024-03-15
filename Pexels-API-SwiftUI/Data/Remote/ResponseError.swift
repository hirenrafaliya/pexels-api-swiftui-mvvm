//
//  ResponseError.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 15/03/24.
//

import Foundation

enum ResponseError: Error {
    case requestFailure(Error)
    case invalidResponse
}

extension ResponseError {
    func getErrorMessage() -> String {
        var errorMessage = "Unknown error!"
        
        switch self {
        case let .requestFailure(error):
            errorMessage = error.localizedDescription
        default:
            errorMessage = "Something went wrong!"
        }
        
        return errorMessage
    }
}

extension Error {
    var errorCode: Int? {
        (self as NSError).code
    }
}

