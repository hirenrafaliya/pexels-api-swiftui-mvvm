//
//  SearchView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ErrorView(error: viewModel.error)
                
                ScrollView {
                    LazyVStack() {
                        if viewModel.photos.isEmpty {
                            placeholder
                        }
                        
                        ForEach(viewModel.photos) { photo in
                            PhotoItem(photo: photo)
                        }
                     }
                }
                .navigationTitle("Search")
                .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search")
                .onSubmit(of: .search) {
                    viewModel.search(for: searchText)
                }
            }
        }
    }
    
    var placeholder: some View {
        VStack(spacing: 4) {
            Image(systemName: "magnifyingglass")
                .font(.largeTitle.weight(.semibold))
                .imageScale(.large)
            Text("Search for images")
                .font(.callout)
        }
        .foregroundColor(.secondary)
        .frame(height: 400)
    }
}
