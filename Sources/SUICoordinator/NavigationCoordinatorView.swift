//
//  NavigationCoordinatorView.swift
//  APP-release
//
//  Created by Noah Plützer on 04.06.24.
//

import SwiftUI

struct NavigationCoordinatorView<RootView: View, Dependencies>: View {
    private let dependencies: Dependencies
    @ObservedObject private var coordinator: AppCoordinator<Dependencies>
    
    let rootView: (AppCoordinator<Dependencies>) -> RootView
    
    init(
        dependencies: Dependencies,
        @ViewBuilder rootView: @escaping (AppCoordinator<Dependencies>) -> RootView
    ) {
        self.dependencies = dependencies
        self.coordinator = AppCoordinator<Dependencies>(
            navigationPath: NavigationPath()
        )
        self.rootView = rootView
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            rootView(coordinator)
                .navigationDestination(for: AnyDestination<Dependencies>.self) { destination in
                    destination.makeView(with: dependencies, coordinator: coordinator)
                }
        }
    }
}

#Preview {
    NavigationCoordinatorView(
        dependencies: Void()
    ) { _ in
        Text("Hello World")
    }
}
