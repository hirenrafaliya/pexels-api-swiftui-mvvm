//
//  CollectionResponse.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation

struct CollectionMediaResponse: Decodable {
    let page: Int
    let media: [Photo]
}
