// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import Foundation

enum Route: Hashable {
    case dashboard
    case entryDetail(UUID)
    case addEntry
    case editEntry(UUID)
    case search
}
