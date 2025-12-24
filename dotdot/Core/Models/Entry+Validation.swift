// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import Foundation

extension Entry {
    enum ValidationError: LocalizedError {
        case titleRequired
        case titleTooLong(maxLength: Int)
        case ratingRequired
        case ratingOutOfRange
        case notesTooLong(maxLength: Int)

        var errorDescription: String? {
            switch self {
            case .titleRequired:
                return "Title is required"
            case .titleTooLong(let maxLength):
                return "Title must be \(maxLength) characters or less"
            case .ratingRequired:
                return "Rating is required for completed entries"
            case .ratingOutOfRange:
                return "Rating must be between 1 and 3"
            case .notesTooLong(let maxLength):
                return "Notes must be \(maxLength) characters or less"
            }
        }
    }

    func validate() throws {
        // Title validation
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ValidationError.titleRequired
        }

        guard title.count <= 200 else {
            throw ValidationError.titleTooLong(maxLength: 200)
        }

        // Rating validation
        // Rating is optional when watching = true, required when watching = false
        if !watching {
            guard let rating = rating else {
                throw ValidationError.ratingRequired
            }

            guard (1...3).contains(rating) else {
                throw ValidationError.ratingOutOfRange
            }
        } else if let rating = rating {
            // If watching is true but rating is provided, validate range
            guard (1...3).contains(rating) else {
                throw ValidationError.ratingOutOfRange
            }
        }

        // Notes validation
        if let notes = notes, notes.count > 1_000 {
            throw ValidationError.notesTooLong(maxLength: 1_000)
        }
    }

    var isValid: Bool {
        do {
            try validate()
            return true
        } catch {
            return false
        }
    }
}
