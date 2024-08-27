// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "Environment",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "Environment",
            targets: ["Environment"]),
    ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
        .package(name: "Networking", path: "../Networking")
    ],
    targets: [
        .target(
            name: "Environment",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "Networking", package: "Networking")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "EnvironmentTests",
            dependencies: ["Environment"]
        ),
    ]
)
