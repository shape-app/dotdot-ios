// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

struct OriginPicker: View {
    @Binding var selectedOrigin: Origin?

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Origin")
                .font(.body)
                .foregroundColor(.textPrimary)

            Menu {
                Button {
                    selectedOrigin = nil
                } label: {
                    HStack {
                        Text("None")
                        if selectedOrigin == nil {
                            Image(systemName: "checkmark")
                        }
                    }
                }

                ForEach(Origin.allCases, id: \.self) { origin in
                    Button {
                        selectedOrigin = origin
                    } label: {
                        HStack {
                            Text(displayName(for: origin))
                            if selectedOrigin == origin {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedOrigin.map { displayName(for: $0) } ?? "None")
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

    private func displayName(for origin: Origin) -> String {
        switch origin {
        case .usa:
            return "USA"
        case .uk:
            return "UK"
        case .korea:
            return "Korea"
        case .japan:
            return "Japan"
        case .china:
            return "China"
        case .taiwan:
            return "Taiwan"
        case .hongKong:
            return "Hong Kong"
        case .thailand:
            return "Thailand"
        case .india:
            return "India"
        case .france:
            return "France"
        case .spain:
            return "Spain"
        case .other:
            return "Other"
        }
    }
}

#Preview {
    OriginPicker(selectedOrigin: .constant(.korea))
        .padding()
        .background(Color.background)
}

