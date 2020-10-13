import Foundation

public struct MarketNews: Codable {
    var category: String
    var datetime: Int
    var headline: String
    var id: Int
    var image: String
    var related: String
    var source: String
    var summary: String
    var url: String
}
