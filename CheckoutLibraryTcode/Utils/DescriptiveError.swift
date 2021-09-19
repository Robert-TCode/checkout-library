//  Created by TCode on 19/9/21.

import Foundation

/// A `protocol` providing access to a `DescriptiveError`.
protocol DescribingError {
    var descriptiveError: DescriptiveError { get }
}

/// A descriptive error the can wrap an `Error` or define a new, custom error.
struct DescriptiveError: LocalizedError {
    var name: String
    var message: String?
    var code: Int?

    /// A detailed description of the error.
    var errorDescription: String? { return _description }

    var _description: String

    /// Initializes a `DescriptiveError`.
    /// - Parameters:
    ///   - name: The name of the error.
    ///   - message: The message of the error.
    ///   - code: The code of the error.
    init(name: String, message: String? = nil, code: Int? = nil) {
        self.name = name
        self.message = message
        self.code = code

        if message != nil {
            self._description = name + " - \(message!)" + "\(code != nil ? " [Code \(code!)]" : "")"
        } else {
            self._description = name + "\(code != nil ? " [Code: \(code!)]" : "")"
        }
    }

    /// Initializes a `DescriptiveError` with a specified `Error` object.
    /// - Parameter error: The error to be converted.
    init(_ error: Error) {
        name = error.localizedDescription
        self._description = String(reflecting: error)
    }
}
