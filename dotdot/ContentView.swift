// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftData
import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            DashboardView()
                .navigationDestination(for: Route.self) { route in
                    destinationView(for: route)
                }
        }
        .environmentObject(router)
    }

    @ViewBuilder
    private func destinationView(for route: Route) -> some View {
        switch route {
        case .dashboard:
            DashboardView()
        case .entryDetail(let entry):
            EntryDetailView(entry: entry)
        case .addEntry:
            AddEntryView()
        case .editEntry(let entry):
            EditEntryView(entry: entry)
        case .search:
            SearchView()
        }
    }
}

#Preview {
    ContentView()
}
