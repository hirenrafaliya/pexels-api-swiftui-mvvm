//
//  ContentView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 15/03/24.
//

import SwiftUI

struct ContentView: View {
    
        let service = PexelsService()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {
            }, label: {
                Text("CALL API")
            })
        }
        .onAppear(perform: {
            Task {
                await service.getCuratedPhotos()
            }
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
