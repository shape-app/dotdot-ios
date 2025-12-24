// Copyright (c) 2025-present Shape
// Licensed under the MIT License

@testable import dotdot
import Foundation
import Testing

struct UserTests {
    @Test func userCodableEncoding() throws {
        let user = User(
            id: "user-123",
            email: "test@example.com",
            createdAt: Date()
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(user)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(User.self, from: data)

        #expect(decoded.id == user.id)
        #expect(decoded.email == user.email)
    }

    @Test func userIdentifiable() {
        let user = User(
            id: "user-123",
            email: "test@example.com",
            createdAt: Date()
        )

        #expect(user.id == "user-123")
    }
}
