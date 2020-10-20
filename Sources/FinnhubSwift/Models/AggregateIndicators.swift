import Foundation

public struct AggregateIndicators: Codable, Equatable {
    public var technicalAnalysis: TechnicalAnalysis
    public var trend: Trend

    public static func == (lhs: AggregateIndicators, rhs: AggregateIndicators) -> Bool {
        return lhs.technicalAnalysis == rhs.technicalAnalysis &&
            lhs.trend == rhs.trend
    }

    /*

     {
         "technicalAnalysis":{
             "count":{
                 "buy":7,
                 "neutral":8,
                 "sell":2
             },
             "signal":"buy"
         },
         "trend":{
             "adx":20.172131665096146,
             "trending":false
         }
     }

     */
}

public struct TechnicalAnalysis: Codable, Equatable {
    public var count: TechnicalAnalysisCount
    public var signal: String

    public static func == (lhs: TechnicalAnalysis, rhs: TechnicalAnalysis) -> Bool {
        return lhs.count == rhs.count &&
            lhs.signal == rhs.signal
    }
}

public struct TechnicalAnalysisCount: Codable, Equatable {
    public var buy: Int
    public var neutral: Int
    public var sell: Int

    public static func == (lhs: TechnicalAnalysisCount, rhs: TechnicalAnalysisCount) -> Bool {
        return lhs.buy == rhs.buy &&
            lhs.neutral == rhs.neutral &&
            lhs.sell == rhs.sell
    }
}

public struct Trend: Codable, Equatable {
    public var adx: Double
    public var trending: Bool

    public static func == (lhs: Trend, rhs: Trend) -> Bool {
        return lhs.adx == rhs.adx &&
            lhs.trending == rhs.trending
    }
}
