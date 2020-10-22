import Foundation

public struct AggregateIndicators: Codable, Equatable, Hashable {
    public var technicalAnalysis: TechnicalAnalysis
    public var trend: Trend

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

public struct TechnicalAnalysis: Codable, Equatable, Hashable {
    public var count: TechnicalAnalysisCount
    public var signal: String
}

public struct TechnicalAnalysisCount: Codable, Equatable, Hashable {
    public var buy: Int
    public var neutral: Int
    public var sell: Int
}

public struct Trend: Codable, Equatable, Hashable {
    public var adx: Double
    public var trending: Bool
}
