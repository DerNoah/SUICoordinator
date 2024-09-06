//
//  Destination.swift
//  aurora
//
//  Created by Noah Plützer on 19.05.24.
//

import SwiftUI

protocol Destination<Dependencies>: Hashable {
    associatedtype DestinationView: View
    associatedtype Dependencies
    associatedtype DestinationIdentifier: Hashable
    
    var identifier: DestinationIdentifier { get }
    
    @ViewBuilder
    func makeView(with dependencies: Dependencies, coordinator: Coordinator) -> DestinationView
}

struct AnyDestination<Dependencies>: Destination {
    let identifier: AnyHashable
    
    var viewBuilder: (Dependencies) -> any View
    
    func makeView(with dependencies: Dependencies, coordinator: any Coordinator) -> AnyView {
        AnyView(viewBuilder(dependencies))
    }
    
    static func == (lhs: AnyDestination<Dependencies>, rhs: AnyDestination<Dependencies>) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
