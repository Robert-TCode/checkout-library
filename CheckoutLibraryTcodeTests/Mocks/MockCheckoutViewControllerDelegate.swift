//  Created by TCode on 19/9/21.

import Foundation
@testable import CheckoutLibraryTcode

class MockCheckoutViewControllerDelegate: CheckoutViewControllerDelegate {

    var didGeneratePaymentTokenCallsCount = 0
    var tokenGenerationFailedCallsCount = 0
    var lastGeneratedToken: String?
    var lastGeneratedError: Error?

    func didGeneratePaymentToken(_ token: String, viewController: CheckoutViewController) {
        lastGeneratedToken = token
        didGeneratePaymentTokenCallsCount += 1
    }

    func tokenGenerationFailed(with error: Error) {
        lastGeneratedError = error
        tokenGenerationFailedCallsCount += 1
    }
}
