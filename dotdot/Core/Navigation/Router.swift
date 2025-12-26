// Copyright (c) 2025-present Shape
// Licensed under the MIT License

import Combine
import SwiftUI

@MainActor
class Router: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to route: Route) {
        path.append(route)
    }

    func navigateBack() {
        path.removeLast()
    }

    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
