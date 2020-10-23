import Foundation

public struct MarketNews: Mappable {
    public var category: String
    public var datetime: Int
    public var headline: String
    public var id: Int
    public var image: String
    public var related: String
    // TODO: We want this parameter, but need special encoding
//    public var summary: String
    public var source: String
    public var url: String

    public static func == (lhs: MarketNews, rhs: MarketNews) -> Bool {
        return lhs.id == rhs.id
    }
}
