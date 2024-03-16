//
//  PhotosView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 16/03/24.
//

import Foundation
import SwiftUI

struct PhotosView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        Text("Photos").onAppear(perform: {
            viewModel.getPhotos()
        })
    }
}