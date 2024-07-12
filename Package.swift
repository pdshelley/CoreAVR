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
package.dependencies.append(
    .package(
        url: "https://github.com/apple/swift-docc-plugin",
        from: "1.0.0"
    )
)
