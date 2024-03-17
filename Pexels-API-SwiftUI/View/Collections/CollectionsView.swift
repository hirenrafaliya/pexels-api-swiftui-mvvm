//
//  CollectionsView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation
import SwiftUI

struct CollectionsView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ErrorView(error: viewModel.error)
                
                List {
                    ForEach(viewModel.collections) { collection in
                        CollectionItem(collection: collection)
                            .onAppear {
                                if collection.id == viewModel.collections.last?.id {
                                    viewModel.getCollections()
                                }
                            }
                    }
                }
                .navigationTitle("Collections")
            }
        }
        
    }
}
