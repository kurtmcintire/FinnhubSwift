import Foundation

public struct EconomicEvent: Mappable {
    public var actual: Float?
    public var country: String
    public var estimate: Float?
    public var event: String
    public var impact: String
    public var prev: Float?
    public var time: String
    public var unit: String
}

public struct EconomicCalendar: Mappable {
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
