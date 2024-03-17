//
//  CollectionsViewModel.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 17/03/24.
//

import Foundation

extension CollectionsView {
    class ViewModel : ObservableObject {
        
        @Published private (set) var collections: [Collection] = []
        @Published private (set) var error: String? = nil
        
        private let pexelsService = PexelsService()
        private var currentPage = 1
        
        init() {
            getCollections()
        }
        
        func getCollections() {
            Task {
                let result = await pexelsService.getCollections(page: String(currentPage))
                switch result {
                case .success(let response) :
                    DispatchQueue.main.async {
                        self.currentPage += 1
                        self.collections.append(contentsOf: response.collections)
                    }
                case .failure(let error):
                    self.error = error.getErrorMessage()
                    return
                }
            }
        }
    }
}
