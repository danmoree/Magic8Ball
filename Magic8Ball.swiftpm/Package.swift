// swift-tools-version: 6.0

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Magic8Ball",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Magic8Ball",
            targets: ["AppModule"],
            bundleIdentifier: "com.danielmoreno.projects.Magic8Ball",
            teamIdentifier: "J722DG3N7J",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .sandwich),
            accentColor: .presetColor(.teal),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ],
    swiftLanguageVersions: [.v6]
)
