//
//  SearchViewModel.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 18/03/24.
//

import Foundation

extension SearchView {
    class ViewModel : ObservableObject {
        
        @Published private (set) var photos: [Photo] = []
        @Published private (set) var error: String? = nil
        
        private let pexelsService = PexelsService()
        
        func search(for text: String) {
            Task {
                let result = await pexelsService.getPhotosFromSearch(search: text, page: "1")
                switch(result) {
                case .success(let response):
                    photos = response.photos
                case .failure(let error):
                    self.error = error.getErrorMessage()
                }
            }
        }
        
    }
}
