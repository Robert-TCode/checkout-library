//  Created by TCode on 19/9/21.

import Foundation

enum NetworkError: DescribingError {
    case requestFailed(code: Int? = nil)
    case parsingFailed
    case noAccessToken
    case failedToCreateRequest

    var descriptiveError: DescriptiveError {
        switch self {
        case .requestFailed(let code):
            return DescriptiveError(name: "Request has failed", code: code)
        case .parsingFailed:
            return DescriptiveError(name: "Parsing response failed")
        case .noAccessToken:
            return DescriptiveError(name: "Access token not found")
        case .failedToCreateRequest:
            return DescriptiveError(name: "Failed to create URLRequest")
        }
    }
}
