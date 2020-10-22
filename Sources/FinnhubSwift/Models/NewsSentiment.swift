import Foundation

public struct Buzz: Mappable {
    public var articlesInLastWeek: Int
    public var buzz: Double
    public var weeklyAverage: Double
}

public struct Sentiment: Mappable {
    public var bearishPercent: Double
    public var bullishPercent: Double
}

public struct NewsSentiment: Mappable {
    public var buzz: Buzz
    public var companyNewsScore: Double
    public var sectorAverageBullishPercent: Double
    public var sectorAverageNewsScore: Double
    public var sentiment: Sentiment
    public var symbol: String
}
