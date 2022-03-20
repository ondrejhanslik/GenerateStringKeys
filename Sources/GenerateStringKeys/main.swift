import Foundation

let args = CommandLine.arguments
let inputFile = URL(fileURLWithPath: args[args.count - 2])
let outputFile = URL(fileURLWithPath: args[args.count - 1])

let reservedIdentifiers = ["continue"]

func generateIdentifier(from key: String) -> String {
    let identifier = key
        .split { separator in [".", "/", "_"].contains(separator) }
        .enumerated()
        .map { $0.offset == 0 ? $0.element.lowercased() : $0.element.capitalized }
        .joined()

    if reservedIdentifiers.contains(identifier) {
        return "`\(identifier)`"
    }

    return identifier
}

func loadTranslations() -> [String: String] {
    guard
        let inputData = try? Data(contentsOf: inputFile),
        let translations = (try? JSONSerialization.jsonObject(with: inputData, options: [])) as? [String: String]
    else {
        fatalError("Could not read input file.")
    }

    return translations
}

func generateStrings(translations: [String: String]) {
    let keys = translations.keys.sorted { $0.localizedStandardCompare($1) == .orderedAscending }
    let stringKeys = keys.map {
        """
            /// \(translations[$0]?.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression) ?? "")
            case \(generateIdentifier(from: $0)) = "\($0)"
        """
    }.joined(separator: "\n")

    let generatedCode = """
    /// Generated file, do not edit manually
    public enum LocalizationKey: String {
    \(stringKeys)
    }
    """

    let outputData = generatedCode.data(using: .utf8)!

    do {
        try outputData.write(to: outputFile)
    } catch {
        print("Could not write to output file: \(outputFile)")
    }
}

print("Generating strings from \(inputFile) to \(outputFile)")

let translations = loadTranslations()
generateStrings(translations: translations)
