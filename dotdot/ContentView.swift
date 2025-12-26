// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import SwiftData
import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()
    @Environment(\.modelContext) private var modelContext

    private var entryRepository: EntryRepository {
        SwiftDataEntryRepository(modelContext: modelContext)
    }

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
        case .entryDetail(let entryID):
            if let entry = entryRepository.fetchEntry(by: entryID) {
                EntryDetailView(entry: entry)
            } else {
                Text("Entry not found")
                    .foregroundColor(.textSecondary)
            }
        case .addEntry:
            AddEntryView()
        case .editEntry(let entryID):
            if let entry = entryRepository.fetchEntry(by: entryID) {
                EditEntryView(entry: entry)
            } else {
                Text("Entry not found")
                    .foregroundColor(.textSecondary)
            }
        case .search:
            SearchView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
