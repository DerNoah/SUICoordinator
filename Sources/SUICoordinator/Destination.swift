//
//  Destination.swift
//  SUICoordinator
//
//  Created by Noah Plützer on 06.09.24.
//

import SwiftUI

protocol Destination<Dependencies>: Hashable, Identifiable {
	associatedtype DestinationView: View
	associatedtype Dependencies
	associatedtype DestinationIdentifier: Hashable
	
	var id: DestinationIdentifier { get }
	
	@ViewBuilder
	func makeView(with dependencies: Dependencies, rootCoordinator: AppCoordinator<Dependencies>) -> DestinationView
}

extension Destination {
	func eraseToAnyDestination(dependencies: Dependencies, rootCoordinator: AppCoordinator<Dependencies>) -> AnyDestination {
		AnyDestination(id: id, viewBuilder: { makeView(with: dependencies, rootCoordinator: rootCoordinator) })
	}
}

public struct AnyDestination: Identifiable, Hashable {
	public let id: AnyHashable
	
	var viewBuilder: () -> any View
	
	func makeView() -> AnyView {
		AnyView(viewBuilder())
	}
	
	public static func == (lhs: AnyDestination, rhs: AnyDestination) -> Bool {
		lhs.id == rhs.id
	}
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
