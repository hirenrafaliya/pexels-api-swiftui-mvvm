//
//  CollectionsResponse.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation

struct CollectionsResponse: Codable {
    let page: Int
    let collections: [Collection]
}

struct Collection: Codable, Identifiable {
    let id: String
    let title: String
    let mediaCount: Int
    let photosCount: Int
    let videosCount: Int
}
