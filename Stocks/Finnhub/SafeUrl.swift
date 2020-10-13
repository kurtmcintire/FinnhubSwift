import Foundation

struct SafeURL {
    static func path(_ string: String) -> URL {
        guard let url = URL(string: string) else {
            fatalError("Malformed URL: \(string)")
        }
        return url
    }
}
