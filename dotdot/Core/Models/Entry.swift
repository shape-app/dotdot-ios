// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import Foundation
import SwiftData

@Model
final class Entry {
    @Attribute(.unique) var id: UUID
    var title: String
    var type: EntryType
    var rating: Int?
    var notes: String?
    var origin: Origin?
    var watching: Bool
    var createdAt: Date
    var updatedAt: Date

    var year: Int {
        Calendar.current.component(.year, from: createdAt)
    }

    init(
        id: UUID = UUID(),
        title: String,
        type: EntryType,
        rating: Int? = nil,
        notes: String? = nil,
        origin: Origin? = nil,
        watching: Bool = false,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.type = type
        self.rating = rating
        self.notes = notes
        self.origin = origin
        self.watching = watching
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
