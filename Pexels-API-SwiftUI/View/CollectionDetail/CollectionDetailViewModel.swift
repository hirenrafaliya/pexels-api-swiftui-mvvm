//
//  CollectionDetailViewModel.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 18/03/24.
//

import Foundation

extension CollectionDetailView {
    
    class ViewModel : ObservableObject {
        
        @Published private (set) var photos: [Photo] = []
        @Published private (set) var error: String? = nil
        
        private let pexelsService = PexelsService()
        private var currentPage = 1
        
        func getCollectionMedia(collectionId: String) {
            Task {
                let result = await pexelsService.getCollectionMedia(collectionId: collectionId, page: String(currentPage))
                
                switch result {
                case .success(let response) :
                    DispatchQueue.main.async {
                        self.currentPage += 1
                        self.photos = response.media
                    }
                case .failure(let error) :
                    self.error = error.getErrorMessage()
                    return
                }
            }
        }
    }
}
