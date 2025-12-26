// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import Foundation
import SwiftData

protocol EntryRepository {
    func fetchEntry(by id: UUID) -> Entry?
}

@MainActor
class SwiftDataEntryRepository: EntryRepository {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchEntry(by id: UUID) -> Entry? {
        let descriptor = FetchDescriptor<Entry>(
            predicate: #Predicate<Entry> { $0.id == id }
        )
        return try? modelContext.fetch(descriptor).first
    }
}

