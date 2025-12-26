// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        DashboardView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
