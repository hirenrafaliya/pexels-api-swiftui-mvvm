//
//  PhotosView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation
import SwiftUI

struct PhotosView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
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
            
        }
    }
}
