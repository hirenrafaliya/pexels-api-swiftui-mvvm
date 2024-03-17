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
        
        private let pexelsService = PexelsService()
        private let currentPage = 1
        
        func getPhotos() {
            Task {
                let result = await pexelsService.getCuratedPhotos(page: String(currentPage))
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.photos = response.photos
                        print(self.photos.count)
                    }
                case .failure(let error):
                    print(error)
                    return
                }
            }
        }
    }
}
