// swift-tools-version:5.10

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "CorePersistence",
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "CorePersistence",
            targets: [
                "_CoreIdentity",
                "_CSV",
                "_JSON",
                "_ModularDecodingEncoding",
                "_SWXMLHash",
                "_XMLCoder",
                "Proquint",
                "UUIDv6",
                "CorePersistence"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/hornmichaels/Merge.git", branch: "7-24"),
	.package(url: "https://github.com/vmanot/Swallow.git", revision: "2a37e106dc657ed064eb2be4a4eb399a2c3da302"),
    ],
    targets: [
        .macro(
            name: "CorePersistenceMacros",
            dependencies: [
                .product(name: "MacroBuilder", package: "Swallow"),
            ],
            path: "Sources/CorePersistenceMacros"
        ),
        .target(
            name: "_ModularDecodingEncoding",
            dependencies: [
                "_CoreIdentity",
                "Merge",
                "Swallow"
            ],
            path: "Sources/_ModularDecodingEncoding",
            swiftSettings: []
        ),
        .target(
            name: "_CoreIdentity",
            dependencies: [
                "CorePersistenceMacros",
                "Merge",
                "Proquint",
                "Swallow"
            ],
            path: "Sources/_CoreIdentity",
            swiftSettings: []
        ),
        .target(
            name: "_CSV",
            dependencies: [
                "Swallow"
            ],
            path: "Sources/_CSV",
            swiftSettings: []
        ),
        .target(
            name: "_JSON",
            dependencies: [
                "Swallow"
            ],
            path: "Sources/_JSON",
            swiftSettings: []
        ),
        .target(
            name: "_SWXMLHash",
            dependencies: [],
            path: "Sources/_SWXMLHash",
            exclude: ["Info.plist"]
        ),
        .target(
            name: "_XMLCoder",
            dependencies: [],
            path: "Sources/_XMLCoder",
            swiftSettings: []
        ),
        .target(
            name: "CorePersistence",
            dependencies: [
                "_CoreIdentity",
                "_JSON",
                "_ModularDecodingEncoding",
                "CorePersistenceMacros",
                "Merge",
                "Proquint",
                "Swallow"
            ],
            swiftSettings: [
                .enableExperimentalFeature("AccessLevelOnImport"),
                .unsafeFlags([])
            ]
        ),
        .target(
            name: "Proquint",
            dependencies: [
                "Swallow"
            ],
            swiftSettings: []
        ),
        .target(
            name: "UUIDv6",
            dependencies: [
                "CorePersistence"
            ]
        ),
        .testTarget(
            name: "CorePersistenceTests",
            dependencies: [
                "CorePersistence"
            ]
        ),
    ]
)
