import Foundation

public struct PriceTarget: Codable, Equatable, Hashable {
    public var lastUpdated: String
    public var symbol: String
    public var targetHigh: Double
    public var targetLow: Double
    public var targetMean: Double
    public var targetMedian: Double
}
