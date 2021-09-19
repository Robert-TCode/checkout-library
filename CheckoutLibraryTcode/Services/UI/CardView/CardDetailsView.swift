//  Created by TCode on 19/9/21.

import UIKit

class CardDetailsView: UIView {

    var cardNumber: String? {
        cardContentView.numberTextField.text
    }
    var holderName: String? {
        cardContentView.nameTextField.text
    }
    var cvv: String? {
        cardContentView.cvvTextField.text
    }
    var expiryMonth: Int? {
        guard let expiryDate = cardContentView.expiryTextField.text else {
            return nil
        }
        guard expiryDate.count == 4 else {
            return nil
        }

        let yearIndex = expiryDate.index(expiryDate.startIndex, offsetBy: 2)
        let monthString = String(expiryDate[expiryDate.startIndex ..< yearIndex])
        return Int(monthString)
    }
    var expiryYear: Int? {
        guard let expiryDate = cardContentView.expiryTextField.text else {
            return nil
        }
        guard expiryDate.count == 4 else {
            return nil
        }

        let yearIndex = expiryDate.index(expiryDate.startIndex, offsetBy: 2)
        let yearString = String(expiryDate[yearIndex ..< expiryDate.endIndex])
        return Int(yearString)
    }

    var backgroundView: CardBackgroundView
    var cardContentView: CardContentView

    public override init(frame: CGRect) {
        backgroundView = CardBackgroundView()
        cardContentView = CardContentView()
        super.init(frame: frame)

        setupViews()
        setupHighlightsForFields()
    }

    public required init?(coder aDecoder: NSCoder) {
        backgroundView = CardBackgroundView()
        cardContentView = CardContentView()
        super.init(coder: aDecoder)

        setupViews()
        setupHighlightsForFields()
    }

    public init(frame: CGRect, template: CardBackgroundView.CCBackgroundTemplate) {
        backgroundView = CardBackgroundView(frame: .zero, template: template)
        cardContentView = CardContentView()
        super.init(frame: frame)

        setupViews()
        setupHighlightsForFields()
    }

    func setupViews() {
        self.addAutoLayoutSubview(backgroundView)
        backgroundView.pinToSuperview()
        backgroundView.layer.cornerRadius = 10.0

        self.addAutoLayoutSubview(cardContentView)
        cardContentView.pinToSuperview()
    }

    func setupHighlightsForFields() {
        cardContentView.numberTextField.borderStyle = .none
        cardContentView.numberTextField.layer.borderColor = UIColor.red.cgColor
        cardContentView.nameTextField.borderStyle = .none
        cardContentView.nameTextField.layer.borderColor = UIColor.red.cgColor
        cardContentView.cvvTextField.borderStyle = .none
        cardContentView.cvvTextField.layer.borderColor = UIColor.red.cgColor
        cardContentView.expiryTextField.borderStyle = .none
        cardContentView.expiryTextField.layer.borderColor = UIColor.red.cgColor

        removeHighlights()
    }

    func highlightCardNumber() {
        cardContentView.numberTextField.layer.borderWidth = 1
    }

    func highlightHolderName() {
        cardContentView.nameTextField.layer.borderWidth = 1
    }

    func highlightCVV() {
        cardContentView.cvvTextField.layer.borderWidth = 1
    }

    func highlightExpiryDate() {
        cardContentView.expiryTextField.layer.borderWidth = 1
    }

    func removeHighlights() {
        cardContentView.numberTextField.layer.borderWidth = 0
        cardContentView.nameTextField.layer.borderWidth = 0
        cardContentView.cvvTextField.layer.borderWidth = 0
        cardContentView.expiryTextField.layer.borderWidth = 0
    }
}
