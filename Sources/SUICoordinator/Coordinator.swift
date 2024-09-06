//
//  Coordinator.swift
//  SUICoordinator
//
//  Created by Noah Plützer on 06.09.24.
//

import Foundation

public protocol Coordinator {
    func push<D: Destination>(destination: D)
    func pop()
}
