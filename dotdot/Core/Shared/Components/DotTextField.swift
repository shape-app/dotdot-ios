// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

struct DotTextField: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var isSecure: Bool = false
    var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(title)
                .font(.body)
                .foregroundColor(.textPrimary)

            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .font(.body)
            .foregroundColor(.textPrimary)
            .padding(Spacing.sm)
            .background(Color.surface)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
            .cornerRadius(8)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.error)
            }
        }
    }

    private var borderColor: Color {
        errorMessage != nil ? .error : .border
    }
}

#Preview {
    VStack(spacing: Spacing.md) {
        DotTextField(
            title: "Email",
            text: .constant(""),
            placeholder: "Enter your email"
        )
        DotTextField(
            title: "Password",
            text: .constant(""),
            placeholder: "Enter your password",
            isSecure: true
        )
        DotTextField(
            title: "Title",
            text: .constant(""),
            placeholder: "Enter title",
            errorMessage: "Title is required"
        )
    }
    .padding()
    .background(Color.background)
}

