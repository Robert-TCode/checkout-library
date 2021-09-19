//  Created by TCode on 14/9/21.

import XCTest
@testable import CheckoutLibraryTcode

class CheckoutLibraryTcodeTests: XCTestCase {

    func test_configureClientToken_savesToken() {
        let testToken = "test-client-token"
        CheckoutLibraryTcode.configure(clientToken: testToken)

        XCTAssertEqual(CheckoutLibraryTcode.getClientToken(), testToken)
    }

    func test_configureClientToken_decodesAccessTokenProperly() {
        CheckoutLibraryTcode.configure(clientToken: TestConstants.testClientToken)

        XCTAssertEqual(CheckoutLibraryTcode.getAccessToken(), TestConstants.testAccessToken)
    }

}
