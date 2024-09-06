//
//  AppCoordinator.swift
//  aurora
//
//  Created by Noah Plützer on 19.05.24.
//

import SwiftUI

final class AppCoordinator<Dependencies>: Coordinator, ObservableObject {
    @Published var navigationPath: NavigationPath
    
    init(navigationPath: NavigationPath) {
        self.navigationPath = navigationPath
    }
    
    func push<D>(destination: D) where D: Destination {
        let anyDestination = AnyDestination(
            identifier: destination.identifier,
            viewBuilder: { [unowned self] dependencyContainer in
                destination.makeView(with: dependencyContainer, coordinator: self)
            }
        )
        navigationPath.append(anyDestination)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
}
