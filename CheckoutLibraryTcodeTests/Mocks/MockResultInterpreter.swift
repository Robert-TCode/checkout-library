//  Created by TCode on 19/9/21.

import Foundation
@testable import CheckoutLibraryTcode

class MockResultInterpreter: ResultInterpreting {

    var handleResultCallsCount = 0
    var resultProvided: Result<Data, Error>?

    func handleResult<Model>(_ result: Result<Data, Error>, model: Model.Type, completion: @escaping (Result<Model, DescriptiveError>) -> Void) where Model: Decodable {
        handleResultCallsCount += 1
        completion(.failure(DescriptiveError(name: "Test-Error")))
    }
}
