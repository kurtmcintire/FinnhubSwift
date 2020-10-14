import Foundation

public protocol LiveResponse {
    var type: String { get set }
}

public enum LiveResponseType: String {
    case trade
    case news
    case ping
}

public struct LiveTrades: Codable, LiveResponse, Equatable {
    var data: [Trade]
    public var type: String

    public static func == (lhs: LiveTrades, rhs: LiveTrades) -> Bool {
        return lhs.data == rhs.data &&
            lhs.type == rhs.type
    }
}

public struct LiveNews: Codable, LiveResponse, Equatable {
    var data: [MarketNews]
    public var type: String

    public static func == (lhs: LiveNews, rhs: LiveNews) -> Bool {
        return lhs.type == rhs.type && lhs.data == rhs.data
    }
}

public struct LivePing: Codable, LiveResponse, Equatable {
    public var type: String

    public static func == (lhs: LivePing, rhs: LivePing) -> Bool {
        return lhs.type == rhs.type
    }
}
