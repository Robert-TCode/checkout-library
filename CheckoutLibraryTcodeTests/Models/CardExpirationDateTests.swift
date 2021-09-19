//  Created by TCode on 19/9/21.

import Foundation
import XCTest
@testable import CheckoutLibraryTcode

class CardExpirationDateTests: XCTestCase {

    func test_expirationDateValidation() {
        var sut = CardExpirationDate(month: 2, year: 4)
        XCTAssertNil(sut)

        sut = CardExpirationDate(month: 22, year: 23)
        XCTAssertNil(sut)

        sut = CardExpirationDate(month: 7, year: 323)
        XCTAssertNil(sut)

        sut = CardExpirationDate(month: 2, year: 24)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.yearString, "2024")
        XCTAssertEqual(sut?.monthString, "02")
    }
}
