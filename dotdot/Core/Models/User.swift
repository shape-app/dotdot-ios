// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let createdAt: Date
}
