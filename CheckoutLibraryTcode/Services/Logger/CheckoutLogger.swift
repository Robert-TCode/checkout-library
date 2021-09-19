//  Created by TCode on 19/9/21.

import Foundation

class CheckoutLogger {

    private static let logsQueue = DispatchQueue(label: "CheckoutLibrary.CheckoutLogger.Queue")

    private static var loggers: [Logger] = [ConsoleLogger(consumedLevels: [.debug, .info, .error, .critical])]

    /// Add a `Logger` to the list.
    /// - Parameter logger: The logger to be added.
    static func addLogger(_ logger: Logger) {
        Self.loggers.append(logger)
    }

    // MARK: Logging String

    /// Log a message within a specified context.
    /// - Parameters:
    ///   - level: The category of the log.
    ///   - message: The message to be logged.
    ///   - context: The context in which the log is triggered.
    public static func log(level: LogLevel, message: @autoclosure () -> String) {
        let message = message()
        logsQueue.async {
            for logger in loggers {
                logger.log(level: level, message: message)
            }
        }
    }

    // MARK: Logging DescriptiveError

    /// Log an error within a specified context.
    /// - Parameters:
    ///   - level: The category of the log.
    ///   - error: The error to be logged.
    ///   - context: The context in which the log is triggered.
    public static func log(level: LogLevel, error: DescriptiveError) {
        if let message = error.errorDescription {
            log(level: level, message: message)
        }
    }
}
