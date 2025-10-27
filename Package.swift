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
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath(".")
            ]
        ),
        .target(
            name: "CoreAVR",
            dependencies: ["CCoreAVR"]
        )
    ]
)
