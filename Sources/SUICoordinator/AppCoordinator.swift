//
//  AppCoordinator.swift
//  SUICoordinator
//
//  Created by Noah Plützer on 06.09.24.
//

import SwiftUI

public final class AppCoordinator<Dependencies>: Coordinator, ObservableObject {
    @Published var navigationPath: NavigationPath
    
    public init(navigationPath: NavigationPath) {
        self.navigationPath = navigationPath
    }
    
    public func push<D>(destination: D) where D: Destination {
        let anyDestination = AnyDestination(
            identifier: destination.identifier,
            viewBuilder: { [unowned self] dependencyContainer in
                destination.makeView(with: dependencyContainer, coordinator: self)
            }
        )
        navigationPath.append(anyDestination)
    }
    
    public func pop() {
        navigationPath.removeLast()
    }
}
