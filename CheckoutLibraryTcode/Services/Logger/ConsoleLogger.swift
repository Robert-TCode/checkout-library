//  Created by TCode on 19/9/21.

import Foundation

/// A concrete `Logger` using the console for output and does not save logs.
class ConsoleLogger: Logger {

    private var consumedLevels = [LogLevel]()

    init(consumedLevels: [LogLevel] = LogLevel.allCases) {
        self.consumedLevels = consumedLevels
    }

    func log(level: LogLevel, message: @autoclosure () -> String) {
        #if DEBUG
        let levelSymbol = Self.symbol(forLevel: level)
        let message = levelSymbol + " " + message()

        if consumedLevels.contains(level) {
            print(message)
        }
        #endif
    }

    private static func symbol(forLevel level: LogLevel) -> String {
        switch level {
        case .debug: return "🛠"
        case .info: return "⚙️"
        case .error: return "❌"
        case .critical: return "🙉"
        }
    }
}
