//
//  NavigationCoordinatorView.swift
//  SUICoordinator
//
//  Created by Noah Plützer on 06.09.24.
//

import SwiftUI

struct NavigationCoordinatorView<RootView: View, Dependencies>: View {
	private let dependencies: Dependencies
	@ObservedObject private var coordinator: AppCoordinator<Dependencies>
	
	private let rootView: (AppCoordinator<Dependencies>) -> RootView
	
	init(
		dependencies: Dependencies,
		@ViewBuilder rootView: @escaping (AppCoordinator<Dependencies>) -> RootView
	) {
		self.dependencies = dependencies
		self.coordinator = AppCoordinator<Dependencies>(dependencies: dependencies)
		self.rootView = rootView
	}
	
	var body: some View {
		NavigationStack(path: $coordinator.navigationStack) {
			rootView(coordinator)
				.navigationDestination(for: AnyDestination.self) { destination in
					destination.makeView()
				}
		}
		.sheet(isPresented: $coordinator.isPresenting, onDismiss: coordinator.onDismiss, content: {
			if let destination = coordinator.presentedDestination {
				destination.makeView()
			}
		})
	}
}

#Preview {
	NavigationCoordinatorView(
		dependencies: Void()
	) { _ in
		Text("Hello World")
	}
}
