//
//  CollectionDetailView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 18/03/24.
//

import Foundation
import SwiftUI

struct CollectionDetailView: View {
    
    let collection: Collection
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            
            ErrorView(error: viewModel.error)
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.photos) { photo in
                        PhotoItem(photo: photo)
//                            .onAppear {
//                                if photo.id == viewModel.photos.last?.id {
//                                    viewModel.getCollectionMedia(collectionId: collection.id)
//                                }
//                            }
                    }
                }
                
            }
        }
        .onAppear {
            viewModel.getCollectionMedia(collectionId: collection.id)
        }
        
    }
}
