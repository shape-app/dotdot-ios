// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

struct EntryTypePicker: View {
    @Binding var selectedType: EntryType

    private var displayName: String {
        switch selectedType {
        case .movie:
            return "Movie"
        case .tvShow:
            return "TV Show"
        case .varietyShow:
            return "Variety Show"
        case .anime:
            return "Anime"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Type")
                .font(.body)
                .foregroundColor(.textPrimary)

            Menu {
                ForEach(EntryType.allCases, id: \.self) { type in
                    Button {
                        selectedType = type
                    } label: {
                        HStack {
                            Text(displayName(for: type))
                            if selectedType == type {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(displayName)
                        .foregroundColor(.textPrimary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.textSecondary)
                        .font(.caption)
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
    }

    private func displayName(for type: EntryType) -> String {
        switch type {
        case .movie:
            return "Movie"
        case .tvShow:
            return "TV Show"
        case .varietyShow:
            return "Variety Show"
        case .anime:
            return "Anime"
        }
    }
}

#Preview {
    EntryTypePicker(selectedType: .constant(.movie))
        .padding()
        .background(Color.background)
}
