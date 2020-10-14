import Foundation

public struct MarketNews: Codable, Equatable {
    var category: String
    var datetime: Int
    var headline: String
    var id: Int
    var image: String
    var related: String
    var source: String
    var summary: String
    var url: String

    public static func == (lhs: MarketNews, rhs: MarketNews) -> Bool {
        return lhs.id == rhs.id
    }
}
