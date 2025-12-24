// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import Foundation

enum Route: Hashable {
    case dashboard
    case entryDetail(Entry)
    case addEntry
    case editEntry(Entry)
    case search
}

