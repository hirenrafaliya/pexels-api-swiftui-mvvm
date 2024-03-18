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
    let showDetails: Bool
    let horizontalPadding: CGFloat
    
    @State private var isExapnded = false
    
    init(photo: Photo, showDetails: Bool = true, horizontalPadding: CGFloat = 12) {
        self.photo = photo
        self.showDetails = showDetails
        self.horizontalPadding = horizontalPadding
    }
    
    var body: some View {
        Group {
            ZStack(alignment: .bottom) {
                image
                
                if showDetails {
                    detail
                }
                    
            }
            .clipShape(RoundedRectangle(cornerRadius: isExapnded ? 16 : 12))
        }
        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 4)
        .padding(.horizontal, isExapnded ? 16 : horizontalPadding)
        .padding(.vertical, isExapnded ? 4 : 2)
    }
    
    var detail: some View {
        HStack(alignment: .center, spacing: 12) {
            HStack {
                subtitleView
                Spacer()
            }
            .offset(x: 0, y: isExapnded ? 0 : 70)
            .opacity(isExapnded ? 1 : 0)
            
            expandButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(isExapnded ? 20 : 16)
        .background(Rectangle()
            .cornerRadius(12)
            .foregroundStyle(.thinMaterial)
            .offset(x: 0, y: isExapnded ? 0 : 70)
            .opacity(isExapnded ? 1 : 0)
            .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 2)
            .padding(8)
        )
    }
    
    var expandButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 1)) {
                isExapnded.toggle()
            }
        } label: {
            Image(systemName: "plus")
                .rotationEffect(isExapnded ?
                    .degrees(-135) : .zero)
                .font(.headline)
        }
        .frame(width: 36,height: 36)
        .background(
            Circle()
                .foregroundStyle(isExapnded ?
                    .regularMaterial : .ultraThickMaterial)
        )
    }
    
    
    var subtitleView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(photo.photographer)
                .font(.headline)
                .foregroundColor(.primary)
            if !photo.photographer.isEmpty {
                Text(photo.alt)
                    .bold()
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    
    var image: some View {
        AsyncImage(url: URL(string: photo.src.large), transaction: Transaction(animation: .easeInOut)) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
                    .transition(.scale(scale: 1.05, anchor: .center).combined(with: .opacity).animation(.easeInOut))
            case .empty:
                ZStack {
                    Rectangle().foregroundColor(.init(hex: photo.avgColor).opacity(0.25))
                    ProgressView()
                }.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
            case .failure(_):
                ZStack {
                    Rectangle().foregroundColor(.init(hex: photo.avgColor))
                    Image(systemName: "wifi.exclamationmark")
                        .font(.largeTitle)
                }.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
            @unknown default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
//        .onTapGesture {
//            withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 2)) {
//                showDetails.toggle()
//            }
//            
//        }
    }
}
