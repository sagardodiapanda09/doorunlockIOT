// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SeosMobileKeysPackage",
    platforms: [
        .iOS(.v13), .watchOS(.v7),
    ],
    products: [
        .library(name: "SeosMobileKeysSDK",
                 targets: [
                    "SeosMobileKeysSDK",
                 ]),
    ],
    targets: [
        .binaryTarget(name: "SeosMobileKeysSDK",
                      path: "../Release/SeosMobileKeysSDK.xcframework"),
    ]
)
           