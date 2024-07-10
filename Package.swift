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
            name: "CoreAVR"//,
//            exclude: ["module.modulemap"] //, "build"
        )
    ]
)
