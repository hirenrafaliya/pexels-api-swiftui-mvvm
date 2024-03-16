//
//  PexelsService.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation

final class PexelsService {
    private let baseURL = "https://api.pexels.com/v1"
    private let router: NetworkRouter
    
    init() {
        self.router = NetworkRouter()
    }
    
    func getCuratedPhotos() async -> Result<CuratedPhotosResponse, ResponseError> {
        do {
            let request = router.buildRequest(url: "\(baseURL)/curated", method: .get)
            let result: Result<CuratedPhotosResponse, ResponseError> = await router.executeRequest(request: request)
//            print(result)
            return result
        }
    }
    
    func getCollections() async -> Result<CollectionsResponse, ResponseError> {
        do {
            let request = router.buildRequest(url: "\(baseURL)/collection/featured", method: .get)
            let result: Result<CollectionsResponse, ResponseError> = await router.executeRequest(request: request)
            return result
        }
    }
    
    func getCollectionMedia(collectionId: String) async -> Result<CollectionMediaResponse, ResponseError> {
        do {
            let request = router.buildRequest(url: "\(baseURL)/collections/\(collectionId)", method: .get)
            let result: Result<CollectionMediaResponse, ResponseError> = await router.executeRequest(request: request)
            return result
        }
    }
}
