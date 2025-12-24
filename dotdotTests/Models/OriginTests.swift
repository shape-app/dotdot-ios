// Copyright (c) 2025-present Shape
// Licensed under the MIT License

@testable import dotdot
import Foundation
import Testing

struct OriginTests {
    @Test func allCasesExist() {
        let cases = Origin.allCases
        #expect(cases.count == 12)
        #expect(cases.contains(.usa))
        #expect(cases.contains(.korea))
        #expect(cases.contains(.japan))
        #expect(cases.contains(.other))
    }

    @Test func rawValues() {
        #expect(Origin.usa.rawValue == "usa")
        #expect(Origin.hongKong.rawValue == "hongKong")
        #expect(Origin.other.rawValue == "other")
    }

    @Test func codableEncoding() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(Origin.korea)
        let jsonString = String(data: data, encoding: .utf8)
        #expect(jsonString == "\"korea\"")
    }

    @Test func codableDecoding() throws {
        let decoder = JSONDecoder()
        let data = Data("\"japan\"".utf8)
        let decoded = try decoder.decode(Origin.self, from: data)
        #expect(decoded == .japan)
    }
}
