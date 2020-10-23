import Foundation

struct Constants {
    static let BASE_URL = "https://finnhub.io/api/v1"
    static let BASE_SOCKET_URL = "wss://ws.finnhub.io"
    static var API_KEY: String {
        guard let filePath = Bundle.main.path(forResource: "Finnhub-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Finnhub-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Finnhub-Info.plist'.")
        }
        if value.starts(with: "_") {
            fatalError("Register for a Finnhub developer account and get an API key at https://finnhub.io/register.")
        }
        return value
    }
}
