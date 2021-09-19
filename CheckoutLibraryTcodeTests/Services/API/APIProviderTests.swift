//  Created by TCode on 19/9/21.

import Foundation
import XCTest
@testable import CheckoutLibraryTcode

class APIProviderTests: XCTestCase {

    private var mockRequestGenerator: MockRequestGenerator!
    private var mockRequestExecutor: MockRequestExecutor!

    private var sut: APIProvider!

    override func setUp() {
        super.setUp()

        mockRequestGenerator = MockRequestGenerator()
        mockRequestExecutor = MockRequestExecutor()
        sut = APIProvider(requestGenerator: mockRequestGenerator, requestExecutor: mockRequestExecutor, resultInterpretor: ResultInterpreter())

        CheckoutLibraryTcode.configure(clientToken: TestConstants.testClientToken)
    }

    override  func tearDown() {
        super.tearDown()

        mockRequestGenerator = nil
        mockRequestExecutor = nil
        sut = nil
    }

    func test_accessTokenProviderWorks() {
        CheckoutLibraryTcode.configure(clientToken: TestConstants.testClientToken)

        XCTAssertEqual(sut.accessToken, TestConstants.testAccessToken)
    }

    func test_paths() {
        XCTAssertEqual(sut.paymentInstrumentsPath, "payment-instruments")
    }

    func test_generatePayment_parametersAreCorrectlyFormatted() {
        sut.generatePayment(cardDetails: TestConstants.testCardDetails) { _ in }

        let parameters = mockRequestGenerator.lastPOSTRequestParameters
        let paymentInstrument = parameters!!["paymentInstrument"] as? [String: Any]

        XCTAssertNotNil(paymentInstrument)

        let number = paymentInstrument!["number"] as? String
        let cvv = paymentInstrument!["cvv"] as? String
        let expirationMonth = paymentInstrument!["expirationMonth"] as? String
        let expirationYear = paymentInstrument!["expirationYear"] as? String
        let cardholderName = paymentInstrument!["cardholderName"] as? String

        XCTAssertEqual(number, "4111111111111111")
        XCTAssertEqual(cvv, "737")
        XCTAssertEqual(expirationMonth, "03")
        XCTAssertEqual(expirationYear, "2030")
        XCTAssertEqual(cardholderName, "J Doe")
    }

    func test_generatePayment_requestFails_completionIsCalled() {
        var apiResult: APIProviding.PaymentTokenResult?
        mockRequestExecutor.resultToBeReturned = .failure(TestConstants.testError)

        let expectation = expectation(description: "Wait for request to be executed")

        sut.generatePayment(cardDetails: TestConstants.testCardDetails) { result in
            apiResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)

        XCTAssertTrue(apiResult != nil)
    }

    func test_generatePayment_requestSucceeds_completionIsCalled() {
        var apiResult: APIProviding.PaymentTokenResult?
        mockRequestGenerator.requestToBeReturned = URLRequest(url: URL(string: "https://google.com")!)
        mockRequestExecutor.resultToBeReturned = .success(TestConstants.paymentTokenResult())

        let expectation = expectation(description: "Wait for request to be executed")

        sut.generatePayment(cardDetails: TestConstants.testCardDetails) { result in
            apiResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)

        let token = try? apiResult?.get()

        XCTAssertTrue(apiResult != nil)
        XCTAssertEqual(token, TestConstants.paymentTokenJSON["token"]!)
    }
}
