import Foundation

struct KotlinGenerator {
    static func generate(with viewModel: ModelInfo) -> String {
        var kotlin = ""
        kotlin += kotlinParcelable(with: viewModel)
        return kotlin
    }

    private static func kotlinParcelable(with viewModel: ModelInfo) -> String {
        var kotlin = "data class \(viewModel.name)(\n"
        kotlin += kotlinValues(from: viewModel.properties)
        kotlin += ")\n"
        return kotlin
    }

    private static func kotlinValues(from properties: [String: String]) -> String {
        var kotlin = ""
        for key in properties.keys.sorted() {
            guard let value = properties[key] else { continue }
            kotlin += "    val \(key): \(value),"

            if key != properties.keys.sorted().last {
                kotlin += "\n"
            }
        }
        kotlin += "\n"
        return kotlin
    }
}
