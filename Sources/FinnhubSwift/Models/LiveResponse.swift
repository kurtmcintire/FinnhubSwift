import Foundation

public protocol LiveResponse {
    var type: String { get set }
}

public enum LiveResponseType: String {
    case trade
    case news
    case ping
}

public struct LiveTrades: Codable, LiveResponse, Equatable, Hashable {
    public var data: [Trade]
    public var type: String
}

public struct LiveNews: Codable, LiveResponse, Equatable, Hashable {
    public var data: [MarketNews]
    public var type: String
}

public struct LivePing: Codable, LiveResponse, Equatable {
    public var type: String
}
