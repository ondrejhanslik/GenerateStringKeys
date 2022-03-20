import PackagePlugin

@main struct LocalizationKeyPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let jsonPath = target.directory.appending(subpath: "Resources/cs/strings.json")
        let generatedFolder = context.pluginWorkDirectory.appending("generated")
        let generatedFile = generatedFolder.appending("LocalizationKey.swift")

        print("Source path: \(jsonPath)")
        print("Generated file: \(generatedFile)")

        return [
            .buildCommand(
                displayName: "Generating localization keys",
                executable: try context.tool(named: "GenerateStringKeys").path,
                arguments: [
                    jsonPath,
                    generatedFile
                ],
                inputFiles: [jsonPath],
                outputFiles: [generatedFile]
                // outputFilesDirectory: generatedFolder
            )
        ]
    }
}
