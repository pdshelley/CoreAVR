// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "CoreAVR",
    products: [
        .library(
            name: "CoreAVR",
            targets: ["CoreAVR"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/TheAlgorithm476/CCoreAVR.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CoreAVR",
            dependencies: ["CCoreAVR"]
        )
    ]
)
