import Foundation

public protocol LiveResponse {
    var type: String { get set }
}

public enum LiveResponseType: String {
    case trade
    case news
    case ping
}

public struct LiveTrades: Codable, LiveResponse {
    var data: [Trade]
    public var type: String
}

public struct LiveNews: Codable, LiveResponse {
    var data: [MarketNews]
    public var type: String
}

public struct LivePing: Codable, LiveResponse {
    public var type: String
}
