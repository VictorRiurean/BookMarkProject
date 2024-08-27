// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "DesignSystems",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "DesignSystems",
            targets: ["DesignSystems"]
        )
    ],
    dependencies: [
        .package(name: "Environment", path: "../Environment"),
        .package(name: "Models", path: "../Models"),
        .package(url: "https://github.com/kean/Nuke", from: "12.8.0")
    ],
    targets: [
        .target(
            name: "DesignSystems",
            dependencies: [
                .product(name: "Environment", package: "Environment"),
                .product(name: "Models", package: "Models"),
                .product(name: "NukeUI", package: "Nuke")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "DesignSystemsTests",
            dependencies: ["DesignSystems"]
        )
    ]
)
