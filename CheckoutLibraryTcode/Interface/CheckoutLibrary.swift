// Created by TCode on 19/9/21.

import Foundation

/// The entry point of the `CheckoutLibraryTcode` library.
@objc public class CheckoutLibrary: NSObject {

    // MARK: Properties

    private var clientToken: String?
    private var accessToken: String?

    private static let shared = CheckoutLibrary()

    private override init() { }

    // MARK: Configuration

    /// Configured the Checkout library with a unique client token.
    /// - Parameter clientToken: The client token to be used for payment token generation.
    @objc public static func configure(clientToken: String) {
        shared.clientToken = clientToken

        let jwt = JWTDecoder.decode(jwtToken: clientToken)
        if let accessToken = jwt["accessToken"] as? String {
            shared.accessToken = accessToken
        } else {
            CheckoutLogger.log(level: .error, message: "JWT token doesn't contain an access token")
        }
    }

    static func getClientToken() -> String? {
        shared.clientToken
    }
    
    static func getAccessToken() -> String? {
        shared.accessToken
    }
}
