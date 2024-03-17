//
//  PhotosViewModel.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 17/03/24.
//

import Foundation

extension PhotosView {
    class ViewModel: ObservableObject {
        
        @Published private (set) var photos: [Photo] = []
        @Published private (set) var error: String? = nil
        
        private let pexelsService = PexelsService()
        private var currentPage = 1
        
        init() {
            getPhotos()
        }
        
        func getPhotos() {
            Task {
                let result = await pexelsService.getCuratedPhotos(page: String(currentPage))
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.currentPage += 1
                        self.photos.append(contentsOf: response.photos)
                    }
                case .failure(let error):
                    self.error = error.getErrorMessage()
                    return
                }
            }
        }
    }
}
