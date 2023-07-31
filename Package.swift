// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "THBPopup",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "THBPopup",
            targets: ["THBPopup"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "THBPopup",
            dependencies: []),
        .testTarget(
            name: "THBPopupTests",
            dependencies: ["THBPopup"]),
    ]
)
