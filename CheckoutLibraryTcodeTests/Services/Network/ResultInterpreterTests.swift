//  Created by TCode on 19/9/21.

import Foundation
import XCTest
@testable import CheckoutLibraryTcode

class ResultInterpreterTests: XCTestCase {

    let sut = ResultInterpreter()

    func test_handleResult_unmatchingStructure_completionWithError() {
        var interpretedResult: Result<PaymentInstrument, DescriptiveError> = .success(TestConstants.testPaymentInstrument)
        let rawResult: Result<Data, Error> = .success(TestConstants.wrongPaymentTokenResult())

        let interpretationExpectation = expectation(description: "Waiting for request to execute.")

        sut.handleResult(rawResult, model: PaymentInstrument.self) { result in
            interpretedResult = result

            interpretationExpectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)

        let expectedResult: Result<PaymentInstrument, DescriptiveError> = .failure(NetworkError.parsingFailed.descriptiveError)
        XCTAssertEqual(interpretedResult, expectedResult)
    }

    func test_handleResult_matchingStructure_completionWithSuccess() {
        var interpretedResult: Result<PaymentInstrument, DescriptiveError> = .failure(NetworkError.parsingFailed.descriptiveError)
        let rawResult: Result<Data, Error> = .success(TestConstants.paymentTokenResult())

        let interpretationExpectation = expectation(description: "Waiting for request to execute.")

        sut.handleResult(rawResult, model: PaymentInstrument.self) { result in
            interpretedResult = result

            interpretationExpectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)

        let expectedResult: Result<PaymentInstrument, DescriptiveError> = .success(TestConstants.testPaymentInstrument)
        XCTAssertEqual(interpretedResult, expectedResult)
    }
}

extension PaymentInstrument: Equatable {
    public static func == (lhs: PaymentInstrument, rhs: PaymentInstrument) -> Bool {
        lhs.token == rhs.token && lhs.tokenType == rhs.tokenType && lhs.paymentInstrumentType == rhs.paymentInstrumentType
    }
}

extension DescriptiveError: Equatable {
    public static func == (lhs: DescriptiveError, rhs: DescriptiveError) -> Bool {
        lhs._description == rhs._description
    }
}
