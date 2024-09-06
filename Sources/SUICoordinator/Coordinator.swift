//
//  Coordinator.swift
//  aurora
//
//  Created by Noah Plützer on 19.05.24.
//

import Foundation

protocol Coordinator {
    func push<D: Destination>(destination: D)
    func pop()
}
