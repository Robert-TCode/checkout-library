//  Created by TCode on 19/9/21.

import Foundation
@testable import CheckoutLibraryTcode

class MockRequestGenerator: RequestGenerating {

    var lastPOSTRequestPath: String?
    var lastPOSTRequestToken: String?
    var lastPOSTRequestParameters: [String: Any]??
    var lastGETRequestPath: String?
    var lastGETRequestToken: String?

    var makePOSTCallsCount = 0
    var makeGETCallsCount = 0

    var requestToBeReturned: URLRequest?

    func makePOST(path: String, token: String?, parameters: [String: Any]?) -> URLRequest? {
        lastPOSTRequestPath = path
        lastPOSTRequestToken = token
        lastPOSTRequestParameters = parameters
        makePOSTCallsCount += 1

        return requestToBeReturned
    }

    func makeGET(path: String, token: String?) -> URLRequest? {
        lastGETRequestPath = path
        lastGETRequestToken = token
        makeGETCallsCount += 1

        return requestToBeReturned
    }
}
