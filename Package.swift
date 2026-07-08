// swift-tools-version: 6.3
// SPDX-License-Identifier: AGPL-3.0-or-later
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cider",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "Cider",
            targets: ["CiderApp"]
        ),
        .library(
            name: "CiderCore",
            targets: ["CiderCore"]
        ),
    ],
    targets: [
        .executableTarget(
            name: "CiderApp",
            dependencies: ["CiderCore"]
        ),
        .target(
            name: "CiderCore",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "CiderCoreTests",
            dependencies: ["CiderCore"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
