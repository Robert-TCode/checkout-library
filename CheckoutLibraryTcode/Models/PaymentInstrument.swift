//  Created by TCode on 19/9/21.

import Foundation

// Note: There are more fields in PaymentInstrument
// but in order to speed things up in this Demo, we'll use just a few (including the token).

struct PaymentInstrument: Codable {
    var token: String
    var tokenType: PaymentTokenType
    var paymentInstrumentType: PaymentInstrumentType
}

enum PaymentTokenType: String, Codable {
    case singleUse = "SINGLE_USE"
    case multipleUse = "MULTIPLE_USE"
}

enum PaymentInstrumentType: String, Codable {
    case card = "PAYMENT_CARD"
}
