//  Created by TCode on 19/9/21.

import Foundation
import XCTest
@testable import CheckoutLibraryTcode

class RequestExecutorTests: XCTestCase {

    let sut = RequestExecutor()

    func test_executeRequest_callsCompletion() {
        let url = URL(string: "https://google.com")!
        let request = URLRequest(url: url)
        var response: Data?
        var error: Error?

        let requestExpectation = expectation(description: "Waiting for request to execute.")

        sut.executeRequest(request) { (completionResult) in
            switch completionResult {
            case .success(let resp):
                response = resp
            case .failure(let err):
                error = err
            }

            requestExpectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
    }
}
