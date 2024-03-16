//
//  TabView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation
import SwiftUI

struct TabItem: Hashable {
    let title: String
    let icon: String
    
    static let photos = TabItem(title: "Photos", icon: "square.stack.3d.up")
    static let collections = TabItem(title: "Collections", icon: "tray.2")
    static let search = TabItem(title: "Search", icon: "magnifyingglass")
}

struct CustomLabel: View {
    
    let tabItem: TabItem
    let isSelected: Bool
    
    var body: some View {
        Label(tabItem.title, systemImage: tabItem.icon)
    }
}
