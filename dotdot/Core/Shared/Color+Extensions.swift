// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

extension Color {
    // Background colors
    static let background = Color(hex: 0x0a0a0a)
    static let surface = Color(hex: 0x1a1a1a)

    // Text colors
    static let textPrimary = Color(hex: 0xffffff)
    static let textSecondary = Color(hex: 0x9ca3af)

    // UI colors
    static let primary = Color(hex: 0xB794F4)
    static let error = Color(hex: 0xef4444)
    static let success = Color(hex: 0x10b981)
    static let border = Color.white.opacity(0.1)
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
