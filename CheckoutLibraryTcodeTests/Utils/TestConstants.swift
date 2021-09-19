//  Created by TCode on 19/9/21.

import Foundation
@testable import CheckoutLibraryTcode

class TestConstants {

    static let testError = NSError.init(domain: "Test-Error", code: 1, userInfo: nil)
    
    static let testCardDetails = CardDetails(number: "4111111111111111", name: "J Doe", cvv: "737", expirationDate: CardExpirationDate(month: 3, year: 30)!)

    // swiftlint:disable:next line_length
    static let testClientToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MzIxMjkzNDksImFjY2Vzc1Rva2VuIjoiMTYyZjhkY2MtM2NiMy00NjgwLTgyZTItNDhiYTA2MGExM2RkIiwiYW5hbHl0aWNzVXJsIjoiaHR0cHM6Ly9hbmFseXRpY3MuYXBpLnN0YWdpbmcuY29yZS5wcmltZXIuaW8vbWl4cGFuZWwiLCJpbnRlbnQiOiJDSEVDS09VVCIsImNvbmZpZ3VyYXRpb25VcmwiOiJodHRwczovL2FwaS5zdGFnaW5nLnByaW1lci5pby9jbGllbnQtc2RrL2NvbmZpZ3VyYXRpb24iLCJjb3JlVXJsIjoiaHR0cHM6Ly9hcGkuc3RhZ2luZy5wcmltZXIuaW8iLCJwY2lVcmwiOiJodHRwczovL3Nkay5hcGkuc3RhZ2luZy5wcmltZXIuaW8iLCJlbnYiOiJTVEFHSU5HIiwidGhyZWVEU2VjdXJlSW5pdFVybCI6Imh0dHBzOi8vc29uZ2JpcmRzdGFnLmNhcmRpbmFsY29tbWVyY2UuY29tL2NhcmRpbmFsY3J1aXNlL3YxL3NvbmdiaXJkLmpzIiwidGhyZWVEU2VjdXJlVG9rZW4iOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpJVXpJMU5pSjkuZXlKcWRHa2lPaUpoTWpZMFptTTFZUzAzWVdJeUxUUTVZVE10WWpOa1lTMWtPVFppTTJGak5tRXdaRFFpTENKcFlYUWlPakUyTXpJd05ESTVORGtzSW1semN5STZJalZsWWpWaVlXVmpaVFpsWXpjeU5tVmhOV1ppWVRkbE5TSXNJazl5WjFWdWFYUkpaQ0k2SWpWbFlqVmlZVFF4WkRRNFptSmtOakE0T0RoaU9HVTBOQ0o5LkotLVRvRUpKNUx0dWZKaHZ5NXdiQ0ZtT25PdkxXLU01NUI0VGdMLVpNV1UiLCJwYXltZW50RmxvdyI6IkRFRkFVTFQifQ.w_ZXZcjn0EYq9RVmMHQRLafI5MSn9Qp2pG4l3ByF_g4"

    static let testAccessToken = "162f8dcc-3cb3-4680-82e2-48ba060a13dd"

    static let paymentTokenJSON = ["token": "some-token",
                                   "tokenType": "SINGLE_USE",
                                   "paymentInstrumentType": "PAYMENT_CARD"]

    static func paymentTokenResult() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: paymentTokenJSON, options: .prettyPrinted)
        } catch {
            return Data()
        }
    }

    static func wrongPaymentTokenResult() -> Data {
        do {
            let wrongPaymentTokenJSON = ["token": "some-token",
                                         "wrongtokenType": "SINGLE_USE_WRONG"]
            return try JSONSerialization.data(withJSONObject: wrongPaymentTokenJSON, options: .prettyPrinted)
        } catch {
            return Data()
        }
    }

    static let testPaymentInstrument = PaymentInstrument(token: "some-token",
                                                         tokenType: .singleUse,
                                                         paymentInstrumentType: .card)
}
