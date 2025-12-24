// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

enum DotButtonStyle {
    case primary
    case secondary
    case destructive
}

struct DotButton: View {
    let title: String
    let style: DotButtonStyle
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    init(
        _ title: String,
        style: DotButtonStyle = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.sm)
                .background(backgroundColor)
                .cornerRadius(8)
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.5)
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .background
        case .secondary:
            return .textPrimary
        case .destructive:
            return .textPrimary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary:
            return .primary
        case .secondary:
            return .surface
        case .destructive:
            return .error
        }
    }
}

#Preview {
    VStack(spacing: Spacing.md) {
        DotButton("Primary Button", style: .primary) {}
        DotButton("Secondary Button", style: .secondary) {}
        DotButton("Destructive Button", style: .destructive) {}
        DotButton("Disabled Button", style: .primary) {}
            .disabled(true)
    }
    .padding()
    .background(Color.background)
}

