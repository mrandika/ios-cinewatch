// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CWGenrePage",
    defaultLocalization: "en",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CWGenrePage",
            targets: ["CWGenrePage"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "CWCommon", path: "../CWCommon"),
        .package(name: "CWMovieGenre", path: "../CWMovieGenre"),
        .package(name: "CWSharedView", path: "../CWSharedView")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CWGenrePage",
            dependencies: [
                "CWCommon",
                "CWMovieGenre",
                "CWSharedView"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "CWGenrePageTests",
            dependencies: ["CWGenrePage"])
    ]
)
