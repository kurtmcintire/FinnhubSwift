import Foundation

public struct CovidCaseCount: Codable, Equatable {
    var usState: String
    var caseCount: Int
    var death: Int
    var updated: String

    enum CodingKeys: String, CodingKey {
        case usState = "state"
        case caseCount = "case"
        case death
        case updated
    }

    public static func == (lhs: CovidCaseCount, rhs: CovidCaseCount) -> Bool {
        return lhs.usState == rhs.usState &&
            lhs.caseCount == rhs.caseCount &&
            lhs.death == rhs.death &&
            lhs.updated == rhs.updated
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
