@testable import FinnhubSwift
import XCTest

final class FDAEventCalendarTests: XCTestCase {
    func testsThatItCreatesFDAEventCalendars() {
        let notJsonString = Data("Hello".utf8)
        let wrong = Data("""
            [
              "AAPL",
              "EMC",
              "HPQ",
              "DELL",
              "WDC",
              "HPE",
              "NTAP",
              "CPQ",
              "SNDK",
              "SEG"
            ]
        """.utf8)
        let partial = Data("""
            [
              {
                "fromDate": "2016-01-11 19:00:00",
                "toDate": "2016-01-11 19:00:00",
              }
            ]
        """.utf8)
        let one = Data("""
            [
              {
                "fromDate": "2016-01-11 19:00:00",
                "toDate": "2016-01-11 19:00:00",
                "eventDescription": "January 12, 2016: Meeting of the Psychopharmacologic Drugs Advisory Committee Meeting Announcement - 01/11/2016 - 01/11/2016",
                "url": "https://www.fda.gov/advisory-committees/advisory-committee-calendar/january-12-2016-meeting-psychopharmacologic-drugs-advisory-committee-meeting-announcement-01112016"
              }
            ]
        """.utf8)
        let many = Data("""
             [
               {
                 "fromDate": "2016-01-11 19:00:00",
                 "toDate": "2016-01-11 19:00:00",
                 "eventDescription": "January 12, 2016: Meeting of the Psychopharmacologic Drugs Advisory Committee Meeting Announcement - 01/11/2016 - 01/11/2016",
                 "url": "https://www.fda.gov/advisory-committees/advisory-committee-calendar/january-12-2016-meeting-psychopharmacologic-drugs-advisory-committee-meeting-announcement-01112016"
               },
               {
                 "fromDate": "2016-01-14 13:00:00",
                 "toDate": "2016-01-14 17:00:00",
                 "eventDescription": "January 14, 2016: Vaccines and Related Biological Products Advisory Committee Meeting Announcement - 01/14/2016 - 01/14/2016",
                 "url": "https://www.fda.gov/advisory-committees/advisory-committee-calendar/january-14-2016-vaccines-and-related-biological-products-advisory-committee-meeting-announcement"
               }
             ]
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: many, expect: true),
            CodableTester(payload: one, expect: true),
            CodableTester(payload: partial, expect: false),
            CodableTester(payload: wrong, expect: false),
            CodableTester(payload: notJsonString, expect: false),
        ]

        for datum in data {
            testsThatItCreatesFDAEventCalendar(data: datum)
        }
    }

    func testsThatItCreatesFDAEventCalendar(data: CodableTester) {
        let country = try? JSONDecoder().decode([FDACalendarEvent].self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(country)
        } else {
            XCTAssertNil(country)
        }
    }

    func testThatEquatable() {
        let fixture1 = FDACalendarEvent(fromDate: "2016-01-14 13:00:00", toDate: "2016-01-14 17:00:00", eventDescription: "January 14, 2016: Vaccines and Related Biological Products Advisory Committee Meeting Announcement - 01/14/2016 - 01/14/2016", url: "https://www.fda.gov/advisory-committees/advisory-committee-calendar/january-14-2016-vaccines-and-related-biological-products-advisory-committee-meeting-announcement")
        let fixture2 = FDACalendarEvent(fromDate: "2016-01-14 13:00:00", toDate: "2016-01-14 17:00:00", eventDescription: "January 14, 2016: Vaccines and Related Biological Products Advisory Committee Meeting Announcement - 01/14/2016 - 01/14/2016", url: "https://www.fda.gov/advisory-committees/advisory-committee-calendar/january-14-2016-vaccines-and-related-biological-products-advisory-committee-meeting-announcement")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = FDACalendarEvent(fromDate: "2016-01-14 13:00:00", toDate: "2016-01-14 17:00:00", eventDescription: "January 14, 2016: Vaccines and Related Biological Products Advisory Committee Meeting Announcement - 01/14/2016 - 01/14/2016", url: "https://www.fda.gov/advisory-committees/advisory-committee-calendar/january-14-2016-vaccines-and-related-biological-products-advisory-committee-meeting-announcement")
        let fixture2 = FDACalendarEvent(fromDate: "2016-01-14 13:00:00", toDate: "2016-01-14 17:00:00", eventDescription: "YUKON CLASSIC", url: "https://www.fda.gov/advisory-committees/advisory-committee-calendar/january-14-2016-vaccines-and-related-biological-products-advisory-committee-meeting-announcement")
        let fixtures: Set<FDACalendarEvent> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
