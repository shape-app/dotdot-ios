// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var placeholder: String = "Search..."

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.textSecondary)

            TextField(placeholder, text: $searchText)
                .font(.body)
                .foregroundColor(.textPrimary)

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.textSecondary)
                }
            }
        }
        .padding(Spacing.sm)
        .background(Color.surface)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.border, lineWidth: 1)
        )
        .cornerRadius(8)
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
        .padding()
        .background(Color.background)
}
