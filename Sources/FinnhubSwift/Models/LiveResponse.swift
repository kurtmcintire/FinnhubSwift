import Foundation

protocol LiveResponse {
    var type: String { get set }
}

enum LiveResponseType: String {
    case trade
    case news
    case ping
}

struct LiveTrades: Codable, LiveResponse {
    var data: [Trade]
    var type: String
}

struct LiveNews: Codable, LiveResponse {
    var data: [MarketNews]
    var type: String
}

struct LivePing: Codable, LiveResponse {
    var type: String
}
