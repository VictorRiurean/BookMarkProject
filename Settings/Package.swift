// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "Settings",
    defaultLocalization: "en",
    platforms: [
      .iOS(.v17),
    ],
    products: [
        .library(
            name: "Settings",
            targets: ["Settings"]
        )
    ],
    dependencies: [
        .package(name: "DesignSystems", path: "../DesignSystems"),
        .package(name: "Environment", path: "../Environment")
    ],
    targets: [
        .target(
            name: "Settings",
            dependencies: [
                .product(name: "DesignSystems", package: "DesignSystems"),
                .product(name: "Environment", package: "Environment")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "SettingsTests",
            dependencies: ["Settings"]
        )
    ]
)
