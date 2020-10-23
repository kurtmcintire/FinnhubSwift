import Foundation

public protocol LiveResponse {
    var type: String { get set }
}

public enum LiveResponseType: String {
    case trade
    case news
    case ping
}

public struct LiveTrades: LiveResponse, Mappable {
    public var data: [Trade]
    public var type: String
}

public struct LiveNews: LiveResponse, Mappable {
    public var data: [MarketNews]
    public var type: String
}

public struct LivePing: LiveResponse, Mappable {
    public var type: String
}
