// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

struct DotCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(Spacing.md)
            .background(Color.surface)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.border, lineWidth: 1)
            )
            .cornerRadius(8)
    }
}

#Preview {
    DotCard {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Card Title")
                .font(.headline)
                .foregroundColor(.textPrimary)
            Text("Card content goes here")
                .font(.body)
                .foregroundColor(.textSecondary)
        }
    }
    .padding()
    .background(Color.background)
}
