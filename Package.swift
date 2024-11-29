// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CardPresentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "CardPresentation",
            targets: [
                "CardPresentation",
            ]
        ),
        .library(
            name: "CardPresentationBuiltins",
            targets: [
                "CardPresentationBuiltins",
            ]
        ),
    ],
    targets: [
        .target(
            name: "CardPresentation"
        ),
        .target(
            name: "CardPresentationBuiltins"
        ),
        .testTarget(
            name: "CardPresentationTests",
            dependencies: ["CardPresentation"]
        ),
    ]
)
