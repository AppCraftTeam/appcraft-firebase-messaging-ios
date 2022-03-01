// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ACFirebaseMessaging",
    defaultLocalization: "ru",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "ACFirebaseMessaging",
            targets: ["ACFirebaseMessaging"]
        ),
    ],
    dependencies: [
        .package(
            name: "Firebase",
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            from: "8.0.0"
        )
    ],
    targets: [
        .target(
            name: "ACFirebaseMessaging",
            dependencies: [
                .product(
                    name: "FirebaseMessaging",
                    package: "Firebase"
                )
            ],
            path: "Sources/ACFirebaseMessaging"
        )
    ]
)
