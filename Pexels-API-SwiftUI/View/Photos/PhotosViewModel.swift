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
        @Published private (set) var photoArray: [[Photo]] = [[],[]]
        @Published private (set) var error: String? = nil
        
        private let pexelsService = PexelsService()
        private var currentPage = 3
        
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
                        self.photoArray = self.splitArray()
                    }
                case .failure(let error):
                    self.error = error.getErrorMessage()
                    return
                }
            }
        }
        
        private func splitArray() -> [[Photo]] {
                var result: [[Photo]] = []
                
                var list1: [Photo] = []
                var list2: [Photo] = []
                
                photos.forEach { photo in
                    let index = photos.firstIndex {$0.id == photo.id }
                    
                    if let index = index {
                        if index % 2 == 0  {
                            list1.append(photo)
                        } else {
                            list2.append(photo)
                        }
                    }
                }
                result.append(list1)
                result.append(list2)
                return result
                
            }
    }
}
