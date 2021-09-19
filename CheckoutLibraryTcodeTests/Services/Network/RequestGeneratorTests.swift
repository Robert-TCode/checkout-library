//  Created by TCode on 19/9/21.

import Foundation
import XCTest
@testable import CheckoutLibraryTcode

class RequestGeneratorTests: XCTestCase {

    let sut = RequestGenerator()

    func test_makeGETRequest_createsCorrectURLRequest() {
        let request = sut.makeGET(path: "test-path", token: "test-token")

        XCTAssertEqual(request?.url?.absoluteString, "https://sdk.api.staging.primer.io/test-path")
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Primer-Client-Token"), "test-token")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func test_makeRequestWithoutToken_returnsNil() {
        let request = sut.makeGET(path: "test-path", token: nil)

        XCTAssertNil(request)
    }

    func test_makePOSTRequest_createsCorrectURLRequest() {
        let request = sut.makePOST(path: "test-path", token: "test-token")

        XCTAssertEqual(request?.url?.absoluteString, "https://sdk.api.staging.primer.io/test-path")
        XCTAssertEqual(request?.httpMethod, "POST")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Primer-Client-Token"), "test-token")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(request?.httpBody, nil)
    }

    func test_makePOSTRequest_attachesParametersCorrectly() {
        let parameters: [String: Any] = ["foo1": 1, "foo2": "bar"]
        let request = sut.makePOST(path: "test-path", token: "test-token", parameters: parameters)

        let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted])
        XCTAssertEqual(request?.httpBody, jsonData)
    }
}
