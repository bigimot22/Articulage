// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArticulageAPI",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "ArtUI", targets: ["ArtUI"]),
        .library(name: "ArtNetwork", targets: ["ArtNetwork"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ArtUI",
            dependencies: []),
        .target(
            name: "ArtNetwork",
            dependencies: [])
    ]
)
