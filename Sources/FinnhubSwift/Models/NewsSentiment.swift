import Foundation

public struct Buzz: Codable, Equatable, Hashable {
    public var articlesInLastWeek: Int
    public var buzz: Double
    public var weeklyAverage: Double
}

public struct Sentiment: Codable, Equatable, Hashable {
    public var bearishPercent: Double
    public var bullishPercent: Double
}

public struct NewsSentiment: Codable, Equatable, Hashable {
    public var buzz: Buzz
    public var companyNewsScore: Double
    public var sectorAverageBullishPercent: Double
    public var sectorAverageNewsScore: Double
    public var sentiment: Sentiment
    public var symbol: String
}
