// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftData
import SwiftUI

struct EditEntryView: View {
    let entry: Entry

    var body: some View {
        VStack {
            Text("Edit Entry")
                .font(.largeTitle)
                .foregroundColor(.textPrimary)
            Text(entry.title)
                .font(.headline)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

#Preview {
    EditEntryView(
        entry: Entry(
            title: "Sample Movie",
            type: .movie,
            rating: 2,
            watching: false
        )
    )
}
