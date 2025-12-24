// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

struct ComponentPreview: View {
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                // Buttons
                VStack(spacing: Spacing.md) {
                    Text("Buttons")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    DotButton("Primary Button", style: .primary) {}
                    DotButton("Secondary Button", style: .secondary) {}
                    DotButton("Destructive Button", style: .destructive) {}
                    DotButton("Disabled Button", style: .primary) {}
                        .disabled(true)
                }

                // Card
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Card")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

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
                }

                // Text Field
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Text Field")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    DotTextField(
                        title: "Title",
                        text: .constant(""),
                        placeholder: "Enter title"
                    )
                    DotTextField(
                        title: "With Error",
                        text: .constant(""),
                        placeholder: "Enter text",
                        errorMessage: "This field is required"
                    )
                }

                // Text Editor
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Text Editor")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    DotTextEditor(
                        title: "Notes",
                        text: .constant(""),
                        placeholder: "Add your notes here...",
                        maxLength: 1000
                    )
                }

                // Rating Picker
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Rating Picker")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    RatingPicker(rating: .constant(2))
                }

                // Entry Type Picker
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Entry Type Picker")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    EntryTypePicker(selectedType: .constant(.movie))
                }

                // Origin Picker
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Origin Picker")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    OriginPicker(selectedOrigin: .constant(.korea))
                }

                // Search Bar
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Search Bar")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    SearchBar(searchText: .constant(""))
                }
            }
            .padding()
        }
        .background(Color.background)
    }
}

#Preview {
    ComponentPreview()
}

