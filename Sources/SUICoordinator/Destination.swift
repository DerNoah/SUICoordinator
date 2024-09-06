//
//  Destination.swift
//  SUICoordinator
//
//  Created by Noah Plützer on 06.09.24.
//

import SwiftUI

public protocol Destination<Dependencies>: Hashable {
    associatedtype DestinationView: View
    associatedtype Dependencies
    associatedtype DestinationIdentifier: Hashable
    
    var identifier: DestinationIdentifier { get }
    
    @ViewBuilder
    func makeView(with dependencies: Dependencies, coordinator: Coordinator) -> DestinationView
}

public struct AnyDestination<Dependencies>: Destination {
    public let identifier: AnyHashable
    
    var viewBuilder: (Dependencies) -> any View
    
    public init(identifier: AnyHashable, viewBuilder: @escaping (Dependencies) -> any View) {
        self.identifier = identifier
        self.viewBuilder = viewBuilder
    }
    
    public func makeView(with dependencies: Dependencies, coordinator: any Coordinator) -> AnyView {
        AnyView(viewBuilder(dependencies))
    }
    
    public static func == (lhs: AnyDestination<Dependencies>, rhs: AnyDestination<Dependencies>) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
