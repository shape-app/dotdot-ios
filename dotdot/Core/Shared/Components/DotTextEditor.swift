// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

struct DotTextEditor: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var errorMessage: String?
    var maxLength: Int?

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(title)
                .font(.body)
                .foregroundColor(.textPrimary)

            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.textSecondary)
                        .padding(.horizontal, Spacing.sm + 4)
                        .padding(.vertical, Spacing.sm + 8)
                }

                TextEditor(text: $text)
                    .font(.body)
                    .foregroundColor(.textPrimary)
                    .scrollContentBackground(.hidden)
                    .padding(Spacing.xs)
                    .background(Color.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(borderColor, lineWidth: 1)
                    )
                    .cornerRadius(8)
                    .frame(minHeight: 100)
            }

            HStack {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.error)
                }

                Spacer()

                if let maxLength = maxLength {
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
            }
        }
    }

    private var borderColor: Color {
        errorMessage != nil ? .error : .border
    }
}

#Preview {
    DotTextEditor(
        title: "Notes",
        text: .constant(""),
        placeholder: "Add your notes here...",
        maxLength: 1_000
    )
    .padding()
    .background(Color.background)
}
