@testable import FinnhubSwift
import XCTest

final class CountryTests: XCTestCase {
    func testThatItCreatesCountries() {
        let countryNotJsonString = Data("Hello".utf8)
        let countryWrong = Data("""
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
        let countryPartial = Data("""
            [{
                 "code2":"NR",
                 "code3":"NRU",
                 "codeNo":"520",
            }]
        """.utf8)
        let countryOne = Data("""
             [
               {
                 "code2": "NR",
                 "code3": "NRU",
                 "codeNo": "520",
                 "country": "Nauru",
                 "currency": "Australian Dollars",
                 "currencyCode": "AUD"
               }
             ]
        """.utf8)

        let countryMany = Data("""
             [
                {
                    "code2":"NR","code3":"NRU","codeNo":"520","country":"Nauru","currency":"Australian Dollars","currencyCode":"AUD"},{"code2":"MF","code3":"MAF","codeNo":"663","country":"Saint Martin (French part)","currency":"Netherlands Antillean guilder","currencyCode":"ANG"},{"code2":"GE","code3":"GEO","codeNo":"268","country":"Georgia","currency":"Lari","currencyCode":"GEL"},{"code2":"AQ","code3":"ATA","codeNo":"10","country":"Antarctica","currency":"Antarctican dollar","currencyCode":"AQD"},{"code2":"VC","code3":"VCT","codeNo":"670","country":"Saint Vincent and the Grenadines","currency":"East Caribbean Dollar","currencyCode":"XCD"},{"code2":"AE","code3":"ARE","codeNo":"784","country":"United Arab Emirates (the)","currency":"Dirham","currencyCode":"AED"},{"code2":"BO","code3":"BOL","codeNo":"68","country":"Bolivia (Plurinational State of)","currency":"Boliviano","currencyCode":"BOB"},{"code2":"KH","code3":"KHM","codeNo":"116","country":"Cambodia","currency":"Riel","currencyCode":"KHR"},{"code2":"GL","code3":"GRL","codeNo":"304","country":"Greenland","currency":"Danish Krone","currencyCode":"DKK"},{"code2":"SD","code3":"SDN","codeNo":"729","country":"Sudan (the)","currency":"Dinar","currencyCode":"SDG"},{"code2":"GQ","code3":"GNQ","codeNo":"226","country":"Equatorial Guinea","currency":"CFA Franc BEAC","currencyCode":"XAF"},{"code2":"KP","code3":"PRK","codeNo":"408","country":"Korea (the Democratic People's Republic of)","currency":"Won","currencyCode":"KPW"},{"code2":"LK","code3":"LKA","codeNo":"144","country":"Sri Lanka","currency":"Rupee","currencyCode":"LKR"
                    }
            ]
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: countryMany, expect: true),
            CodableTester(payload: countryOne, expect: true),
            CodableTester(payload: countryPartial, expect: false),
            CodableTester(payload: countryWrong, expect: false),
            CodableTester(payload: countryNotJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreatesCountry(data: datum)
        }
    }

    func testThatItCreatesCountry(data: CodableTester) {
        let country = try? JSONDecoder().decode([Country].self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(country)
        } else {
            XCTAssertNil(country)
        }
    }

    func testThatEquatable() {
        let fixture1 = Country(codeTwo: "NR", codeThree: "NRU", codeNo: "520", country: "Nauru", currency: "Australian Dollars", currencyCode: "AUD")
        let fixture2 = Country(codeTwo: "NR", codeThree: "NRU", codeNo: "520", country: "Nauru", currency: "Australian Dollars", currencyCode: "AUD")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = Country(codeTwo: "NR", codeThree: "NRU", codeNo: "520", country: "Nauru", currency: "Australian Dollars", currencyCode: "AUD")
        let fixture2 = Country(codeTwo: "AR", codeThree: "ARU", codeNo: "510", country: "ANauru", currency: "Australian Dollars", currencyCode: "AUD")
        let fixtures: Set<Country> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
