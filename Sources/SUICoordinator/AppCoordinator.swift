//
//  AppCoordinator.swift
//  SUICoordinator
//
//  Created by Noah Plützer on 06.09.24.
//

import SwiftUI

public final class AppCoordinator<Dependencies>: Coordinator, ObservableObject {
	@Published var navigationStack: [AnyDestination] = []
	
	@Published var isPresenting: Bool = false
	@Published var presentedDestination: (AnyDestination)?
	
	private let dependencies: Dependencies
	
	private var onPresentationDismiss: (() -> Void)?
	
	init(dependencies: Dependencies, navigationStack: [AnyDestination] = []) {
		self.dependencies = dependencies
		self.navigationStack = navigationStack
	}
	
	func push<D>(destination: D, clearStack: Bool = false) where D: Destination, D.Dependencies == Dependencies {
		let anyDestination = destination.eraseToAnyDestination(dependencies: dependencies, rootCoordinator: self)
		push(anyDestination: anyDestination, clearStack: clearStack)
	}
	
	func push(anyDestination: AnyDestination, clearStack: Bool = false) {
		if clearStack {
			navigationStack = [anyDestination]
		} else {
			navigationStack.append(anyDestination)
		}
	}
	
	func pop() {
		navigationStack.removeLast()
	}
	
	func present<D: Destination>(destination: D, onDismiss: (() -> Void)?) where D.Dependencies == Dependencies {
		let anyDestination = destination.eraseToAnyDestination(dependencies: dependencies, rootCoordinator: self)
		onPresentationDismiss = onDismiss
		presentedDestination = anyDestination
		isPresenting = true
	}
	
	func dismiss(completion: (() -> Void)?) {
		completion?()
		isPresenting = false
	}
	
	func onDismiss() {
		onPresentationDismiss?()
		onPresentationDismiss = nil
	}
}
