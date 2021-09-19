//  Created by TCode on 19/9/21.

import Foundation
@testable import CheckoutLibraryTcode

class MockAPIProvider: APIProviding {

    var generatePaymenyCallsCount = 0
    var cardDetailsProvided: CardDetails?
    var paymentTokenToBeReturned: PaymentTokenResult = .failure(TestConstants.testError)

    func generatePayment(cardDetails: CardDetails, completion: @escaping (PaymentTokenResult) -> Void) {
        generatePaymenyCallsCount += 1
        cardDetailsProvided = cardDetails
        completion(paymentTokenToBeReturned)
    }
}
