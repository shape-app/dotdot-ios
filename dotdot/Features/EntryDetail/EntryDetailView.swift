// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftData
import SwiftUI

struct EntryDetailView: View {
    let entry: Entry

    var body: some View {
        VStack {
            Text("Entry Detail")
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
    EntryDetailView(
        entry: Entry(
            title: "Sample Movie",
            type: .movie,
            rating: 2,
            watching: false
        )
    )
}
