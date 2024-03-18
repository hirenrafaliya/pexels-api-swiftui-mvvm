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
                        LazyVStack {
                            ForEach(viewModel.photos) { photo in
                                    PhotoItem(photo: photo)
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
}
