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
    @State private var showLarge = false
    @State private var currentPhoto: Photo? = nil
    
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {

                    ErrorView(error: viewModel.error)
                    
                    ScrollView {
                        gridPhotosView
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
            .zIndex(1)
            
            if showLarge {
                VisualEffectView(uiVisualEffect: UIBlurEffect(style: .light))
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .zIndex(2)
            }
            
            if showLarge {
                PhotoItem(photo: currentPhoto!)
                    .matchedGeometryEffect(id: currentPhoto!.id, in: namespace, properties: .position)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showLarge.toggle()
                        }
                    }
                    .zIndex(4)
            }
        }
    }
    
    func photosView(photos: [Photo]) -> some View {
        LazyVStack {
            ForEach(photos) { photo in
                PhotoItem(photo: photo, showDetails: false, horizontalPadding: 1)
                    .onTapGesture {
                        currentPhoto = photo
                        withAnimation(.spring()) {
                            showLarge.toggle()
                        }
                    }
                    .onAppear {
                        if photo.id == viewModel.photos.last?.id {
                            viewModel.getPhotos()
                        }
                    }
                    .matchedGeometryEffect(id: photo.id, in: namespace, properties: .frame)
                    .zIndex(currentPhoto?.id == photo.id ? 4 : -1)
            }
        }
    }
    
    var gridPhotosView: some View {
        HStack(alignment: .top) {
            photosView(photos: viewModel.photoArray[0])
            photosView(photos: viewModel.photoArray[1])
        }
        .padding(.horizontal, 6)
    }
}
