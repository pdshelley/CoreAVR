// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "CoreAVR",
    products: [
        .library(
            name: "CoreAVR",
            targets: ["CoreAVR"]
        )
    ],
    targets: [
        .target(
            name: "CCoreAVR",
            path: "Sources/CCoreAVR",
            publicHeadersPath: "include"
        ),
        .target(
            name: "CoreAVR",
            dependencies: [
                .target(name: "CCoreAVR")
            ],
            path: "Sources/CoreAVR"
        )
    ]
)
