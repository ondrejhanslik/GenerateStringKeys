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
            url: "https://github.com/ondrejhanslik/LocalizationKeyPlugin/releases/download/1.0.2/GenerateStringKeys.artifactbundle.zip",
            checksum: "d3ad83d78854226eeff40a3236992553d75e4344f01bd618187783b1664e27ab"
        ),
        .plugin(
            name: "LocalizationKeyPlugin",
            capability: .buildTool(),
            dependencies: ["GenerateStringKeys"],
            path: "Plugins"
        )
    ]
)
