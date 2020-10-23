import Foundation

public struct LiveNews: LiveResponse, Mappable {
    public var data: [MarketNews]
    public var type: String
}
