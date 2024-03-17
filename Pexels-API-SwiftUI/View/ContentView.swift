//
//  ContentView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 15/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentTab = TabItem.photos
    
    var body: some View {
        TabView(selection: $currentTab, content:  {
            
            PhotosView(
                onSearchClick: {
                    currentTab = .search
                }
            ).tabItem {
                CustomLabel(tabItem: TabItem.photos, isSelected: true)
            }.tag(TabItem.photos)
            
            CollectionsView().tabItem {
                CustomLabel(tabItem: TabItem.collections,isSelected: false)
            }.tag(TabItem.collections)
            
            SearchView().tabItem {
                CustomLabel(tabItem: TabItem.search, isSelected: false)
            }.tag(TabItem.search)
            
        })
    }
}

#Preview {
    ContentView()
}
