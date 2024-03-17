//
//  PexelsService.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation

final class PexelsService {
    public let baseURL: String = "https://api.pexels.com/v1"
    private let router: NetworkRouter
    
    init() {
        self.router = NetworkRouter()
    }
    
    func getCuratedPhotos(page: String) async -> Result<CuratedPhotosResponse, ResponseError> {
        do {
            let request = router.buildRequest(url: "\(baseURL)/curated", method: .get, queryParams: ["page": page])
            let result: Result<CuratedPhotosResponse, ResponseError> = await router.executeRequest(request: request)
            return result
        }
    }
    
    func getCollections(page: String) async -> Result<CollectionsResponse, ResponseError> {
        do {
            let request = router.buildRequest(url: "\(baseURL)/collections/featured", method: .get, queryParams: ["page": page])
            let result: Result<CollectionsResponse, ResponseError> = await router.executeRequest(request: request)
            return result
        }
    }
    
    func getCollectionMedia(collectionId: String, page: String) async -> Result<CollectionMediaResponse, ResponseError> {
        do {
            let request = router.buildRequest(url: "\(baseURL)/collections/\(collectionId)", method: .get, queryParams: ["page": page])
            let result: Result<CollectionMediaResponse, ResponseError> = await router.executeRequest(request: request)
            return result
        }
    }
    
    func getPhotosFromSearch(search: String, page: String) async -> Result<CuratedPhotosResponse, ResponseError> {
        do {
            let request = router.buildRequest(url: "\(baseURL)/search", method: .get, queryParams: ["query": search])
            let result: Result<CuratedPhotosResponse, ResponseError> = await router.executeRequest(request: request)
            return result
        }
    }
}
