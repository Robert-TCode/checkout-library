//  Created by TCode on 19/9/21.

import Foundation
@testable import CheckoutLibraryTcode

class MockRequestExecutor: RequestExecuting {

    var executeRequestCallsCount = 0
    var lastRequestExecuted: URLRequest?

    var resultToBeReturned: Result<Data, Error> = .failure(TestConstants.testError)

    func executeRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        lastRequestExecuted = request
        executeRequestCallsCount += 1

        completion(resultToBeReturned)
    }
}
