// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "LocalizationKeyPlugin",
    products: [
        .plugin(
            name: "LocalizationKeyPlugin",
            targets: ["LocalizationKeyPlugin"]
        )
    ],
    targets: [
        .executableTarget(
            name: "GenerateStringKeys"
        ),
        .plugin(
            name: "LocalizationKeyPlugin",
            capability: .buildTool(),
            dependencies: ["GenerateStringKeys"],
            path: "Plugins"
        )
    ]
)
