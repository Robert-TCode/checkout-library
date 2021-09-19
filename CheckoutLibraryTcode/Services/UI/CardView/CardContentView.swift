//  Created by TCode on 19/9/21.

import UIKit

class CardContentView: UIView {

    // MARK: Properties

    var numberTextField: UITextField
    var nameTextField: UITextField
    var expiryTextField: UITextField
    var cvvTextField: UITextField

    private var brandLabel: UILabel
    private var cvvView: UIView
    private var nameTitleLabel: UILabel
    private var expTitleLabel: UILabel
    private var bottomStack: UIStackView

    // swiftlint:disable weak_delegate
    private let cardNumberTextFieldDelegate = CardNumberTextFieldDelegate()
    private let expiryDateTextFieldDelegate = ExpiryDateTextFieldDelegate()
    private let cvvTextFieldDelegate = CVVTextFieldDelegate()

    // MARK: Initializers

    override init(frame: CGRect) {
        brandLabel = UILabel()
        numberTextField = UITextField()
        nameTextField = UITextField()
        expiryTextField = UITextField()
        cvvView = UIView()
        cvvTextField = UITextField()
        nameTitleLabel = UILabel()
        expTitleLabel = UILabel()
        bottomStack = UIStackView()

        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        brandLabel = UILabel()
        numberTextField = UITextField()
        nameTextField = UITextField()
        expiryTextField = UITextField()
        cvvView = UIView()
        cvvTextField = UITextField()
        nameTitleLabel = UILabel()
        expTitleLabel = UILabel()
        bottomStack = UIStackView()

        super.init(coder: aDecoder)
        setupViews()
    }

    // MARK: Subviews configuration

    private func setupViews() {
        addBrandLabel()
        addNumberTextField()
        configureCVVcomponent()

        self.addSubview(bottomStack)
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.axis = .horizontal
        bottomStack.alignment = .fill
        bottomStack.distribution = .fill
        bottomStack.spacing = 12

        bottomStack.addArrangedSubview(createNameStack())
        bottomStack.addArrangedSubview(createExpiryDateStack())
        bottomStack.addArrangedSubview(cvvView)

        bottomStack.layoutSubviews()

        NSLayoutConstraint.activate([
            cvvView.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, multiplier: 0.25),
            cvvTextField.centerXAnchor.constraint(equalTo: cvvView.centerXAnchor),
            cvvTextField.centerYAnchor.constraint(equalTo: cvvView.centerYAnchor),
            cvvTextField.leadingAnchor.constraint(equalTo: cvvView.leadingAnchor, constant: 4),
            cvvTextField.trailingAnchor.constraint(equalTo: cvvView.trailingAnchor, constant: -4),
            bottomStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            bottomStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            bottomStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            bottomStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func addBrandLabel() {
        // Note: Add a method to switch between VISA, Mastercard and other providers.

        self.addSubview(brandLabel)
        brandLabel.text = "VISA"
        brandLabel.textColor = UIColor.white
        brandLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        brandLabel.adjustsFontForContentSizeCategory = true
        brandLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            brandLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            brandLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            brandLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }

    private func addNumberTextField() {
        self.addSubview(numberTextField)
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.textColor = UIColor.white
        numberTextField.textAlignment = .center
        numberTextField.font = UIFont(name: "HelveticaNeue-Medium", size: 29)
        numberTextField.attributedPlaceholder =
            NSAttributedString(string: "0000 0000 0000 0000",
                               attributes: [NSAttributedString.Key.foregroundColor: DesignSystem.placeholderColor])

        numberTextField.contentScaleFactor = 0.5
        numberTextField.adjustsFontSizeToFitWidth = true
        numberTextField.adjustsFontForContentSizeCategory = true
        numberTextField.accessibilityLabel = NSLocalizedString("Card number", comment: "Card number")

        numberTextField.keyboardType = .numberPad
        numberTextField.delegate = cardNumberTextFieldDelegate

        NSLayoutConstraint.activate([
            numberTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            numberTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            numberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }

    private func createNameStack() -> UIStackView {
        nameTitleLabel.text = "Card Holder Name"
        nameTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
        nameTitleLabel.textColor = UIColor.white
        nameTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        nameTextField.textColor = UIColor.white
        nameTextField.attributedPlaceholder =
            NSAttributedString(string: "Robert Tcode",
                               attributes: [NSAttributedString.Key.foregroundColor: DesignSystem.placeholderColor])
        nameTextField.contentScaleFactor = 0.5
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.adjustsFontForContentSizeCategory = true
        nameTextField.accessibilityLabel = NSLocalizedString("Cardholder name", comment: "Cardholder number")

        let dStack: UIStackView = UIStackView(arrangedSubviews: [nameTitleLabel, nameTextField])
        dStack.axis = .vertical
        dStack.alignment = .fill
        dStack.distribution = .fillEqually
        dStack.spacing = -10
        dStack.translatesAutoresizingMaskIntoConstraints = false

        return dStack
    }

    private func createExpiryDateStack() -> UIStackView {
        expTitleLabel.text = "Exp Date"
        expTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
        expTitleLabel.textColor = UIColor.white
        expTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        expiryTextField.attributedPlaceholder =
                NSAttributedString(string: "MMYY",
                                   attributes: [NSAttributedString.Key.foregroundColor: DesignSystem.placeholderColor])
        expiryTextField.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        expiryTextField.textColor = UIColor.white
        expiryTextField.translatesAutoresizingMaskIntoConstraints = false

        expiryTextField.contentScaleFactor = 0.5
        expiryTextField.adjustsFontSizeToFitWidth = true
        expiryTextField.adjustsFontForContentSizeCategory = true
        expiryTextField.accessibilityLabel = NSLocalizedString("Card expiry date", comment: "Card expiry date")

        expiryTextField.keyboardType = .numberPad
        expiryTextField.delegate = expiryDateTextFieldDelegate

        let eStack: UIStackView = UIStackView(arrangedSubviews: [expTitleLabel, expiryTextField])
        eStack.axis = .vertical
        eStack.alignment = .fill
        eStack.distribution = .fillEqually
        eStack.spacing = -10
        eStack.translatesAutoresizingMaskIntoConstraints = false

        return eStack
    }

    private func configureCVVcomponent() {
        cvvView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        cvvView.layer.cornerRadius = 10.0
        cvvView.translatesAutoresizingMaskIntoConstraints = false

        cvvView.addSubview(cvvTextField)
        cvvTextField.translatesAutoresizingMaskIntoConstraints = false
        cvvTextField.textColor = UIColor.white
        cvvTextField.textAlignment = .center
        cvvTextField.attributedPlaceholder =
                NSAttributedString(string: "CVV",
                                   attributes: [NSAttributedString.Key.foregroundColor: DesignSystem.placeholderColor])
        cvvTextField.font = UIFont(name: "HelveticaNeue-Medium", size: 23)

        cvvTextField.adjustsFontSizeToFitWidth = true
        cvvTextField.contentScaleFactor = 0.5
        cvvTextField.adjustsFontSizeToFitWidth = true

        cvvTextField.adjustsFontForContentSizeCategory = true
        cvvTextField.accessibilityLabel = NSLocalizedString("Card CVV", comment: "Card CVV")

        cvvTextField.keyboardType = .numberPad
        cvvTextField.delegate = cvvTextFieldDelegate
    }
}
