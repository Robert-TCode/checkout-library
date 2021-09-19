//  Created by TCode on 19/9/21.

import Foundation

// TODO Use Sourcery to generate Mocks for protocols if you still have time.

/// A protocol providing methods to generate `URLRequest`s.
protocol RequestGenerating {

    /// Generates a request of type `POST` with the given token and parameters.
    /// - Parameters:
    ///   - path: The endpoint of the request.
    ///   - token: The access token of the request.
    ///   - parameters: The parameters to be sent. Optional.
    func makePOST(path: String, token: String?, parameters: [String: Any]?) -> URLRequest?

    /// Generates a request of type `GET` with the given token and parameters.
    /// - Parameters:
    ///   - path: The endpoint of the request.
    ///   - token: The access token of the request.
    func makeGET(path: String, token: String?) -> URLRequest?
}

extension RequestGenerating {

    /// Generates a request of type `POST` with the given token without any parameters.
    /// - Parameters:
    ///   - path: The endpoint of the request.
    ///   - token: The access token of the request.
    func makePOST(path: String, token: String?) -> URLRequest? {
        makePOST(path: path, token: token, parameters: nil)
    }
}

/// A concrete implementation of `RequestGenerating` using Primer's API.
class RequestGenerator: RequestGenerating {

    private let baseURL = "https://sdk.api.staging.primer.io/"
    private let accessTokenField = "Primer-Client-Token"

    func makePOST(path: String, token: String?, parameters: [String: Any]?) -> URLRequest? {
        var request = makeRequest(path: path, method: "POST", token: token)
        if let existentParameters = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: existentParameters, options: [.prettyPrinted])
            request?.httpBody = jsonData
        }
        return request
    }

    func makeGET(path: String, token: String?) -> URLRequest? {
        makeRequest(path: path, method: "GET", token: token)
    }

    private func makeRequest(path: String, method: String, token: String?) -> URLRequest? {
        guard let token = token else {
            CheckoutLogger.log(level: .error, error: NetworkError.noAccessToken.descriptiveError)
            return nil
        }

        guard let url = URL(string: baseURL + path) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(token, forHTTPHeaderField: accessTokenField)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
