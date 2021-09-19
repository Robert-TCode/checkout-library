//  Created by TCode on 19/9/21.

import Foundation

/// A protocol providing a method to convert a `Result`'s `Data` to a specific structure.
protocol ResultInterpreting {

    /// Converts a `Result` contianing `Data` to a `Result` containing a given structure. It can fail if `Data` doesn't have the expected format.
    /// - Parameters:
    ///   - result: The result to be handled.
    ///   - model: The expected structure of the data.
    ///   - completion: The modified  `Result`.
    func handleResult<Model: Decodable>(_ result: Result<Data, Error>, model: Model.Type, completion: @escaping (Result<Model, DescriptiveError>) -> Void)
}

/// A concrete implementation of  `ResultInterpreting` using `JSONSerialization`.
class ResultInterpreter: ResultInterpreting {

    func handleResult<Model: Decodable>(_ result: Result<Data, Error>, model: Model.Type, completion: @escaping (Result<Model, DescriptiveError>) -> Void) {
        switch result {
        case .success(let resultData):
            if let model = try? JSONDecoder().decode(model, from: resultData) {
                completion(.success(model))
            } else {
                completion(.failure(NetworkError.parsingFailed.descriptiveError))
            }
        case .failure(let error):
            completion(.failure(DescriptiveError(error)))
        }
    }
}
