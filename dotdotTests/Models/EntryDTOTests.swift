// Copyright (c) 2025-present Shape
// Licensed under the MIT License

@testable import dotdot
import Foundation
import Testing

struct EntryDTOTests {
    @Test func entryToDTOMapping() {
        let entry = Entry(
            id: UUID(),
            title: "Test Movie",
            type: .movie,
            rating: 2,
            notes: "Test notes",
            origin: .usa,
            watching: false,
            createdAt: Date(),
            updatedAt: Date()
        )

        let dto = EntryDTO(from: entry)

        #expect(dto.id == entry.id.uuidString)
        #expect(dto.title == entry.title)
        #expect(dto.type == entry.type.rawValue)
        #expect(dto.rating == entry.rating)
        #expect(dto.notes == entry.notes)
        #expect(dto.origin == entry.origin?.rawValue)
        #expect(dto.watching == entry.watching)
        #expect(dto.createdAt == entry.createdAt)
        #expect(dto.updatedAt == entry.updatedAt)
    }

    @Test func dtoToEntryMapping() throws {
        let uuid = UUID()
        let date = Date()
        let dto = EntryDTO(
            id: uuid.uuidString,
            title: "Test Movie",
            type: "movie",
            rating: 2,
            notes: "Test notes",
            origin: "usa",
            watching: false,
            createdAt: date,
            updatedAt: date
        )

        let entry = try Entry(from: dto)

        #expect(entry.id == uuid)
        #expect(entry.title == dto.title)
        #expect(entry.type == .movie)
        #expect(entry.rating == dto.rating)
        #expect(entry.notes == dto.notes)
        #expect(entry.origin == .usa)
        #expect(entry.watching == dto.watching)
        #expect(entry.createdAt == dto.createdAt)
        #expect(entry.updatedAt == dto.updatedAt)
    }

    @Test func dtoToEntryMappingWithInvalidUUID() {
        let dto = EntryDTO(
            id: "invalid-uuid",
            title: "Test Movie",
            type: "movie",
            rating: nil,
            notes: nil,
            origin: nil,
            watching: true,
            createdAt: Date(),
            updatedAt: Date()
        )

        do {
            _ = try Entry(from: dto)
            Issue.record("Expected mapping error")
        } catch EntryMappingError.invalidUUID {
            // Expected
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func dtoToEntryMappingWithInvalidEntryType() {
        let uuid = UUID()
        let dto = EntryDTO(
            id: uuid.uuidString,
            title: "Test Movie",
            type: "invalid_type",
            rating: nil,
            notes: nil,
            origin: nil,
            watching: true,
            createdAt: Date(),
            updatedAt: Date()
        )

        do {
            _ = try Entry(from: dto)
            Issue.record("Expected mapping error")
        } catch EntryMappingError.invalidEntryType {
            // Expected
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func dtoToEntryMappingWithOptionalFields() throws {
        let uuid = UUID()
        let dto = EntryDTO(
            id: uuid.uuidString,
            title: "Test Movie",
            type: "anime",
            rating: nil,
            notes: nil,
            origin: nil,
            watching: true,
            createdAt: Date(),
            updatedAt: Date()
        )

        let entry = try Entry(from: dto)

        #expect(entry.rating == nil)
        #expect(entry.notes == nil)
        #expect(entry.origin == nil)
        #expect(entry.type == .anime)
    }

    @Test func roundTripMapping() throws {
        let originalEntry = Entry(
            title: "Round Trip Movie",
            type: .tvShow,
            rating: 3,
            notes: "Excellent show",
            origin: .korea,
            watching: false
        )

        let dto = EntryDTO(from: originalEntry)
        let mappedEntry = try Entry(from: dto)

        #expect(mappedEntry.id == originalEntry.id)
        #expect(mappedEntry.title == originalEntry.title)
        #expect(mappedEntry.type == originalEntry.type)
        #expect(mappedEntry.rating == originalEntry.rating)
        #expect(mappedEntry.notes == originalEntry.notes)
        #expect(mappedEntry.origin == originalEntry.origin)
        #expect(mappedEntry.watching == originalEntry.watching)
    }
}
