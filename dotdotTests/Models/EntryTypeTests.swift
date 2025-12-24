// Copyright (c) 2025-present Shape
// Licensed under the MIT License

@testable import dotdot
import Testing

struct EntryTypeTests {
    @Test func allCasesExist() {
        let cases = EntryType.allCases
        #expect(cases.count == 4)
        #expect(cases.contains(.movie))
        #expect(cases.contains(.tvShow))
        #expect(cases.contains(.varietyShow))
        #expect(cases.contains(.anime))
    }

    @Test func rawValues() {
        #expect(EntryType.movie.rawValue == "movie")
        #expect(EntryType.tvShow.rawValue == "tv_show")
        #expect(EntryType.varietyShow.rawValue == "variety_show")
        #expect(EntryType.anime.rawValue == "anime")
    }

    @Test func codableEncoding() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(EntryType.movie)
        let jsonString = String(data: data, encoding: .utf8)
        #expect(jsonString == "\"movie\"")
    }

    @Test func codableDecoding() throws {
        let decoder = JSONDecoder()
        let data = Data("\"tv_show\"".utf8)
        let decoded = try decoder.decode(EntryType.self, from: data)
        #expect(decoded == .tvShow)
    }
}
