//
//  PhotosView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation
import SwiftUI

struct PhotosView: View {
    
    let onSearchClick: () -> Void
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ErrorView(error: viewModel.error)
                
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.photos) { photo in
                            PhotoItem(photo: photo)
                                .onAppear {
                                    if photo.id == viewModel.photos.last?.id {
                                        viewModel.getPhotos()
                                    }
                                }
                        }
                    }
                }
                .navigationTitle("Curated Photos")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button { onSearchClick() } label: {
                            Label("Search", systemImage: "magnifyingglass")
                                .foregroundColor(.accentColor)
                                .labelStyle(.iconOnly)
                        }
                    }
                })
                
            }
            
        }
    }
}
