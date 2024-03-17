//
//  ErrorView.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 18/03/24.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let error: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                            .font(.system(size: 25))
            
            Text(error)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 18)
                .padding(.vertical, 2)
        }
    }
}
