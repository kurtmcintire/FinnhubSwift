import Foundation

public struct CovidCaseCount: Mappable {
    public var usState: String
    public var caseCount: Int
    public var death: Int
    public var updated: String

    enum CodingKeys: String, CodingKey {
        case usState = "state"
        case caseCount = "case"
        case death
        case updated
    }

    /*

      [{
         "state":"New York",
         "case":482327,
         "death":33306,
         "updated":"2020-10-15 00:00:29"
      },
      {
         "state":"New Jersey",
         "case":215112,
         "death":16302,
         "updated":"2020-10-15 00:00:29"
      }]

     */
}
