//  Created by TCode on 19/9/21.

import Foundation

/// A protocol providing a method for executing requests.
protocol RequestExecuting: AnyObject {

    /// Executes a request and returns the result using a completion handler.
    /// - Parameters:
    ///   - request: The request to be executed.
    ///   - completion: The compeltion of the process.
    func executeRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

/// A concrete implementation of `RequestExecuting` using `URLSession.shared`.
class RequestExecutor: RequestExecuting {

    func executeRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }

            self?.logStatusCodeIfUnsuccessful(response: response)

        }.resume()
    }

    private func logStatusCodeIfUnsuccessful(response: URLResponse?) {
        if let code = response?.responseCode,
           code != 200 {
            CheckoutLogger.log(level: .error, error: NetworkError.requestFailed(code: code).descriptiveError)
        }
    }
}
