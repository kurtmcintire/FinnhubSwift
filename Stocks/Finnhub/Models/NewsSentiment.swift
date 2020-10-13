import Foundation

struct Buzz: Codable {
    var articlesInLastWeek: Int
    var buzz: Double
    var weeklyAverage: Double
}

struct Sentiment: Codable {
    var bearishPercent: Double
    var bullishPercent: Double
}

struct NewsSentiment: Codable {
    var buzz: Buzz
    var companyNewsScore: Double
    var sectorAverageBullishPercent: Double
    var sectorAverageNewsScore: Double
    var sentiment: Sentiment
    var symbol: String
}
