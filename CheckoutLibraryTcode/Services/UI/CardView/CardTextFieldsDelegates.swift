//  Created by TCode on 19/9/21.

import UIKit

class CardNumberTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let onlyContainsNumbers = string.allSatisfy { char in
            Int(String(char)) != nil
        }

        let length = textField.text?.count ?? 0 + string.count
        return onlyContainsNumbers && (length < 16 || string.isEmpty)
    }
}

class ExpiryDateTextFieldDelegate: NSObject, UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let onlyContainsNumbers = string.allSatisfy { char in
            Int(String(char)) != nil
        }

        let length = textField.text?.count ?? 0 + string.count
        return onlyContainsNumbers && (length < 4 || string.isEmpty)
    }
}

class CVVTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let onlyContainsNumbers = string.allSatisfy { char in
            Int(String(char)) != nil
        }

        let length = textField.text?.count ?? 0 + string.count
        return onlyContainsNumbers && (length < 3 || string.isEmpty)
    }
}
