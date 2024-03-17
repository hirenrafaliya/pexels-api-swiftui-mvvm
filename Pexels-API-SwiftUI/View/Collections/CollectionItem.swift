//
//  CollectionItem.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 17/03/24.
//

import Foundation
import SwiftUI

struct CollectionItem: View {
    
    let collection: Collection
    
    var body: some View {
        NavigationLink {
            CollectionDetailView(collection: collection)
            
            .navigationTitle(collection.title)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(collection.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(collection.photosCount.formatted() + " Photos")
                        .bold()
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
                Spacer()
            }
        }
        .listRowBackground(
            Rectangle()
                .cornerRadius(12)
                .foregroundStyle(.thickMaterial)
                .padding(.vertical, 4)
            
        )
        .listRowSeparator(.hidden)
        
    }
}
