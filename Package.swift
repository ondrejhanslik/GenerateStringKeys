// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "LocalizationKeyPlugin",
    // platforms: [.macOS(.v11)],
    products: [
        /*
        .executable(
            name: "GenerateStringKeys",
            targets: ["GenerateStringKeys"]
        ),
        */
        .plugin(
            name: "LocalizationKeyPlugin",
            targets: ["LocalizationKeyPlugin"]
        )
    ],
    targets: [
        /*
        .executableTarget(
            name: "GenerateStringKeys"
        ),
        */
        .binaryTarget(
            name: "GenerateStringKeys",
            url: "https://github.com/ondrejhanslik/GenerateStringKeys/releases/download/1.0.0/GenerateStringKeys.artifactbundle.zip",
            checksum: "32d5a1cd19d59d81955373f183588ef290a43fc295920b7c37c8e52084c76f8c"
        ),
        .plugin(
            name: "LocalizationKeyPlugin",
            capability: .buildTool(),
            dependencies: ["GenerateStringKeys"],
            path: "Plugins"
        )
    ]
)
