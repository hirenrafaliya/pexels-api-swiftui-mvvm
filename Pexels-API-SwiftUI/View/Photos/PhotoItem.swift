//
//  PhotoItem.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 17/03/24.
//

import Foundation
import SwiftUI

struct PhotoItem: View {
    let photo: Photo
    
    var body: some View {
        Group {
            ZStack(alignment: .bottom) {
                image
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 4)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
    
    var image: some View {
        AsyncImage(url: URL(string: photo.src.large), transaction: Transaction(animation: .easeInOut)) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .transition(.scale(scale: 1.05, anchor: .center).combined(with: .opacity).animation(.easeInOut))
            case .empty:
                ZStack {
                    Rectangle().foregroundColor(.init(hex: photo.avgColor).opacity(0.25))
                    ProgressView()
                }.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
            case .failure(_):
                ZStack {
                    Rectangle().foregroundColor(.init(photo.avgColor))
                    ProgressView()
                }.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
            @unknown default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
    }
}
