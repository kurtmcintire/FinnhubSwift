import Foundation

public struct Buzz: Mappable {
    public var articlesInLastWeek: Int
    public var buzz: Float
    public var weeklyAverage: Float
}

public struct Sentiment: Mappable {
    public var bearishPercent: Float
    public var bullishPercent: Float
}

public struct NewsSentiment: Mappable {
    public var buzz: Buzz
    public var companyNewsScore: Float
    public var sectorAverageBullishPercent: Float
    public var sectorAverageNewsScore: Float
    public var sentiment: Sentiment
    public var symbol: String
}
