import Foundation

public struct EconomicEvent: Codable, Equatable, Hashable {
    public var actual: Double?
    public var country: String
    public var estimate: Double?
    public var event: String
    public var impact: String
    public var prev: Double?
    public var time: String
    public var unit: String
}

public struct EconomicCalendar: Codable, Equatable, Hashable {
    public var economicCalendar: [EconomicEvent]

    /*

      {
         "economicCalendar":[{
             "actual":1133,
             "country":"NZ",
              "estimate":null,
              "event":"New Zealand-Tourist arrivals-Estimated Migrant Arrivals",
              "impact":"low",
              "prev":-172,
              "time":"2020-10-11 21:45:00",
              "unit":"Number of"
         }]
      }
     */
}
