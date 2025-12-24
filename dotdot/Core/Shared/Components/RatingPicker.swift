// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

struct RatingPicker: View {
    @Binding var rating: Int?
    let labels: [String] = ["Good", "Great", "Excellent"]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Rating")
                .font(.body)
                .foregroundColor(.textPrimary)

            HStack(spacing: Spacing.md) {
                ForEach(1...3, id: \.self) { value in
                    Button {
                        rating = rating == value ? nil : value
                    } label: {
                        VStack(spacing: Spacing.xs) {
                            Circle()
                                .fill(rating == value ? Color.primary : Color.surface)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Circle()
                                        .stroke(rating == value ? Color.primary : Color.border, lineWidth: 2)
                                )

                            Text(labels[value - 1])
                                .font(.caption)
                                .foregroundColor(rating == value ? .textPrimary : .textSecondary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RatingPicker(rating: .constant(2))
        .padding()
        .background(Color.background)
}

