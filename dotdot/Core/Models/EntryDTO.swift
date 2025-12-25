// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import Foundation

struct EntryDTO: Codable {
    let id: String
    let title: String
    let type: String
    let rating: Int?
    let notes: String?
    let origin: String?
    let watching: Bool
    let createdAt: Date
    let updatedAt: Date
}

// MARK: - Entry ↔ EntryDTO Mapping

extension EntryDTO {
    init(from entry: Entry) {
        self.id = entry.id.uuidString
        self.title = entry.title
        self.type = entry.type.rawValue
        self.rating = entry.rating
        self.notes = entry.notes
        self.origin = entry.origin?.rawValue
        self.watching = entry.watching
        self.createdAt = entry.createdAt
        self.updatedAt = entry.updatedAt
    }
}

extension Entry {
    convenience init(from dto: EntryDTO) throws {
        guard let id = UUID(uuidString: dto.id) else {
            throw EntryMappingError.invalidUUID
        }

        guard let type = EntryType(rawValue: dto.type) else {
            throw EntryMappingError.invalidEntryType
        }

        let origin: Origin? = dto.origin.flatMap { Origin(rawValue: $0) }

        self.init(
            id: id,
            title: dto.title,
            type: type,
            rating: dto.rating,
            notes: dto.notes,
            origin: origin,
            watching: dto.watching,
            createdAt: dto.createdAt,
            updatedAt: dto.updatedAt
        )
    }
}

enum EntryMappingError: Error {
    case invalidUUID
    case invalidEntryType
}
