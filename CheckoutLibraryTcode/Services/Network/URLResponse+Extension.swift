//  Created by TCode on 19/9/21.

import Foundation

extension URLResponse {

    var responseCode: Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
