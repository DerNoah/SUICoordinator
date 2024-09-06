// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SUICoordinator",
    platforms: [.iOS("16")],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SUICoordinator",
            targets: ["SUICoordinator"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SUICoordinator"),
        .testTarget(
            name: "SUICoordinatorTests",
            dependencies: ["SUICoordinator"]),
    ]
)
