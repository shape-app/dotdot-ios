// Copyright (c) 2025-present Shape
// Licensed under the MIT License

@testable import dotdot
import Foundation
import Testing

struct EntryTests {
    @Test func yearComputation() throws {
        let calendar = Calendar.current
        let date2024 = try #require(calendar.date(from: DateComponents(year: 2_024, month: 6, day: 15)))
        let entry = Entry(
            title: "Test Movie",
            type: .movie,
            createdAt: date2024
        )
        #expect(entry.year == 2_024)
    }

    @Test func yearComputationCurrentYear() {
        let entry = Entry(
            title: "Test Movie",
            type: .movie,
            createdAt: Date()
        )
        let currentYear = Calendar.current.component(.year, from: Date())
        #expect(entry.year == currentYear)
    }

    @Test func validationValidEntry() throws {
        let entry = Entry(
            title: "Valid Movie",
            type: .movie,
            rating: 2,
            watching: false
        )
        try entry.validate()
        #expect(entry.isValid == true)
    }

    @Test func validationTitleRequired() {
        let entry = Entry(
            title: "",
            type: .movie,
            watching: false
        )
        #expect(entry.isValid == false)
        do {
            try entry.validate()
            Issue.record("Expected validation error")
        } catch Entry.ValidationError.titleRequired {
            // Expected
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func validationTitleTooLong() {
        let longTitle = String(repeating: "a", count: 201)
        let entry = Entry(
            title: longTitle,
            type: .movie,
            watching: false
        )
        #expect(entry.isValid == false)
        do {
            try entry.validate()
            Issue.record("Expected validation error")
        } catch Entry.ValidationError.titleTooLong {
            // Expected
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func validationRatingRequiredForCompleted() {
        let entry = Entry(
            title: "Test Movie",
            type: .movie,
            watching: false
        )
        #expect(entry.isValid == false)
        do {
            try entry.validate()
            Issue.record("Expected validation error")
        } catch Entry.ValidationError.ratingRequired {
            // Expected
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func validationRatingOptionalWhenWatching() throws {
        let entry = Entry(
            title: "Test Movie",
            type: .movie,
            watching: true
        )
        try entry.validate()
        #expect(entry.isValid == true)
    }

    @Test func validationRatingOutOfRange() {
        let entry = Entry(
            title: "Test Movie",
            type: .movie,
            rating: 5,
            watching: false
        )
        #expect(entry.isValid == false)
        do {
            try entry.validate()
            Issue.record("Expected validation error")
        } catch Entry.ValidationError.ratingOutOfRange {
            // Expected
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func validationNotesTooLong() {
        let longNotes = String(repeating: "a", count: 1_001)
        let entry = Entry(
            title: "Test Movie",
            type: .movie,
            notes: longNotes,
            rating: 2,
            watching: false
        )
        #expect(entry.isValid == false)
        do {
            try entry.validate()
            Issue.record("Expected validation error")
        } catch Entry.ValidationError.notesTooLong {
            // Expected
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func validationValidWithAllFields() throws {
        let entry = Entry(
            title: "Complete Movie",
            type: .movie,
            rating: 3,
            notes: "Great movie!",
            origin: .usa,
            watching: false
        )
        try entry.validate()
        #expect(entry.isValid == true)
    }
}
