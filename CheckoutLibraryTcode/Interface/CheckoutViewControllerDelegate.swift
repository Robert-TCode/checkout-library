//  Created by TCode on 14/9/21.

import Foundation

/// A protocol providing updates on payment tokens generation.
public protocol CheckoutViewControllerDelegate: AnyObject {

    /// Called when a payment token has been generated using the payment details provided in the `CheckoutViewController`.
    /// - Parameters:
    ///   - token: The unique token of the payment.
    ///   - viewController: The `CheckoutViewController` used for collecting payment method details.
    func didGeneratePaymentToken(_ token: String, viewController: CheckoutViewController)

    /// Called when a payment token generation fails.
    /// - Parameter error: An error describing the reason of the failure.
    func tokenGenerationFailed(with error: Error)
}
