import Foundation

public struct Buzz: Codable {
    public var articlesInLastWeek: Int
    public var buzz: Double
    public var weeklyAverage: Double
}

public struct Sentiment: Codable {
    public var bearishPercent: Double
    public var bullishPercent: Double
}

public struct NewsSentiment: Codable {
    public var buzz: Buzz
    public var companyNewsScore: Double
    public var sectorAverageBullishPercent: Double
    public var sectorAverageNewsScore: Double
    public var sentiment: Sentiment
    public var symbol: String
}
