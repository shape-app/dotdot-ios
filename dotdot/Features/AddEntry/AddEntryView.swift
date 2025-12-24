// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftUI

struct AddEntryView: View {
    var body: some View {
        VStack {
            Text("Add Entry")
                .font(.largeTitle)
                .foregroundColor(.textPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

#Preview {
    AddEntryView()
}

