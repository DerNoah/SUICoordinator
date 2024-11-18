//
//  Coordinator.swift
//  SUICoordinator
//
//  Created by Noah Plützer on 06.09.24.
//

import Foundation

protocol Coordinator<Dependencies> {
	associatedtype Dependencies
	
	func push<D: Destination>(destination: D, clearStack: Bool) where D.Dependencies == Dependencies
	func pop()
	func present<D: Destination>(destination: D, onDismiss: (() -> Void)?) where D.Dependencies == Dependencies
	func dismiss(completion: (() -> Void)?)
}

extension Coordinator {
	func push<D: Destination>(destination: D) where D.Dependencies == Dependencies {
		push(destination: destination, clearStack: false)
	}
	
	func present<D: Destination>(destination: D) where D.Dependencies == Dependencies {
		present(destination: destination, onDismiss: nil)
	}
	
	func dismiss() {
		dismiss(completion: nil)
	}
}
