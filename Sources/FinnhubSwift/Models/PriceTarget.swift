import Foundation

struct PriceTarget: Codable {
    var lastUpdated: String
    var symbol: String
    var targetHigh: Double
    var targetLow: Double
    var targetMean: Double
    var targetMedian: Double
}
