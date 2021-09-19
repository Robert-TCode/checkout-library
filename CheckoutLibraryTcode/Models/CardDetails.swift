//  Created by TCode on 14/9/21.

import Foundation

struct CardDetails {
    var number: String
    var name: String
    var cvv: String
    var expirationDate: CardExpirationDate
}

struct CardExpirationDate {
    var month: Int
    var year: Int

    var monthString: String {
        if month >= 10 {
            return String(month)
        } else {
            return "0" + String(month)
        }
    }
    var yearString: String {
        "20" + String(year)
    }

    init?(month: Int, year: Int) {
        guard month >= 1 && month <= 12 else {
            return nil
        }
        guard year <= 99 else {
            return nil
        }

        let currentYear = Calendar.current.component(.year, from: Date())
        let shortYear = currentYear % 100
        guard year >= shortYear else {
            return nil
        }

        let curentMonth = Calendar.current.component(.month, from: Date())
        if year == shortYear && month < curentMonth {
            return nil
        }

        self.year = year
        self.month = month
    }
}
