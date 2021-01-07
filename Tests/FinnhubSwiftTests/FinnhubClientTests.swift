@testable import FinnhubSwift
import XCTest

final class FinnhubClientTests: XCTestCase {
    func testThatItParsesResponsesSuccessful() {
        let companySymbol = CompanySymbol(description: "USD", displaySymbol: "AGILENT TECHNOLOGIES INC", symbol: "A", type: "A", currency: "EQS")
        let responseResult: Result<[CompanySymbol]?, Error> = .success([companySymbol])
        let parsed = FinnhubClient.parseResponse(result: responseResult)

        guard case let .success(success) = parsed else {
            XCTFail("Expected .success")
            return
        }

        XCTAssertEqual([companySymbol], success)
    }

    func testThatItParsesResponsesInvalid() {
        let responseResult: Result<[CompanySymbol]?, Error> = .success(nil)
        let parsed = FinnhubClient.parseResponse(result: responseResult)

        guard case let .failure(fail) = parsed else {
            XCTFail("Expected .failure")
            return
        }

        guard case .invalidData = fail else {
            XCTFail("Expected .invalidData")
            return
        }
    }

    func testThatItParsesResponsesError() {
        enum MockError: Error {
            case someError
        }
        let responseResult: Result<[CompanySymbol]?, Error> = .failure(MockError.someError)
        let parsed = FinnhubClient.parseResponse(result: responseResult)

        guard case let .failure(fail) = parsed else {
            XCTFail("Expected .failure")
            return
        }

        guard case .networkFailure = fail else {
            XCTFail("Expected .networkFailure")
            return
        }
    }

    func testThatItValidatesDates() {
        let dates = [
            "2012-08-24",
            "2020-12-31",
            "1900-01-01",
            "500-01-01",
            "1-01-01",
            "0001-01-01",
        ]
        for date in dates {
            XCTAssertNotNil(FinnhubClient.validateDateString(date: date))
        }
    }
}
