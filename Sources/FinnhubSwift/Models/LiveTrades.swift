import Foundation

public struct LiveTrades: LiveResponse, Mappable {
    public var data: [Trade]
    public var type: String
}
