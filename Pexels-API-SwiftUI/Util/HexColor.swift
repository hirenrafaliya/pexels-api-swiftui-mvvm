//
//  HexColor.swift
//  Pexels-API-SwiftUI
//
//  Created by Hiren Rafaliya on 17/03/24.
//

import Foundation
import SwiftUI

public extension Color {
    
    // MARK: - Initializers
    
    ///  Creates a Color Object using a HEX String
    /// - Parameter hex: A 12, 24, or 32 Bit Hex String (e.g. "ABC", "AABBCC", "99AABBCC")
    ///
    /// Note: When using the 32 Bit String, the first two Characters describe the Alpha Channel
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if (hex.map { $0.hexDigitValue }).contains(nil) {
            self.init(white: 0)
            return
        }
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255
        )
    }
}
