// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cSwift-Package-Example",
    dependencies: [],
    targets: [
        .target(name: "myCTarget"),
        .target(
            name: "cSwift-Package-Example",
            dependencies: ["myCTarget"]),
    ]
)
