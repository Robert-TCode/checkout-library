//  Created by TCode on 19/9/21.

import Foundation

/// A `protocol` able to log a message in a context.
protocol Logger {

    /// Registers a log with a specific log level.
    /// - Parameters:
    ///   - level: The `LogLevel` for a the current log.
    ///   - message: The message to be logged.
    func log(level: LogLevel, message: @autoclosure () -> String)
}

/// The level of a log, used for describing category and importance.
enum LogLevel: String, CaseIterable {

    /// Log information `only` for debugging purposes.
    case debug

    /// Log information to understand the flow of the system.
    case info

    /// Log recoverable errors.
    case error

    /// Log critical errors that cannot be reverted or handled.
    case critical
}
