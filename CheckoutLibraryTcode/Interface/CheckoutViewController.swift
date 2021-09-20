//  Created by TCode on 14/9/21.

import Foundation
import UIKit

/// A `ViewController` responsible for the UI and functionality of the checkout process.
@objc public class CheckoutViewController: UIViewController {

    // MARK: Properties

    private var uiComponentsGenerator: UIComponentsGenerating
    private var requestGenerator: RequestGenerating
    private var requestExecutor: RequestExecuting
    private var resultInterpreting: ResultInterpreting
    private var apiProvider: APIProviding

    private let logoImage: UIImage
    private let payButtonProperties: PayButtonProperties

    /// The delegate providing callbacks for payment token generation.
    @objc public weak var delegate: CheckoutViewControllerDelegate?

    // MARK: Intialization and Lifecycle

    /// Initializes a `CheckoutViewController` with the default UI properties.
    @objc public init() {
        self.logoImage = UIImage(named: "default-logo", in: Bundle.module, compatibleWith: nil)!
        self.payButtonProperties = PayButtonProperties()

        // Compose main elements
        uiComponentsGenerator = UIKitComponentsGenerator()
        requestGenerator = RequestGenerator()
        requestExecutor = RequestExecutor()
        resultInterpreting = ResultInterpreter()
        apiProvider = APIProvider(requestGenerator: requestGenerator, requestExecutor: requestExecutor, resultInterpretor: resultInterpreting)

        super.init(nibName: nil, bundle: nil)

        setUpSubviews()
    }

    /// Initializes a `CheckoutViewController` with custom UI properties.
    /// - Parameters:
    ///   - logoImage: The logo to be displayed in the checkout view. If missing, the default logo is being used.
    ///   - payButtonProperties: The properties of the Pay button in the checkout view.
    @objc public init(logoImage: UIImage,
                      payButtonProperties: PayButtonProperties) {

        self.logoImage = logoImage
        self.payButtonProperties = payButtonProperties

        // Compose main elements
        uiComponentsGenerator = UIKitComponentsGenerator()
        requestGenerator = RequestGenerator()
        requestExecutor = RequestExecutor()
        resultInterpreting = ResultInterpreter()
        apiProvider = APIProvider(requestGenerator: requestGenerator, requestExecutor: requestExecutor, resultInterpretor: resultInterpreting)

        super.init(nibName: nil, bundle: nil)

        setUpSubviews()
    }

    /// Initializes a `CheckoutViewController` with the default UI properties.
    @objc required init?(coder: NSCoder) {
        self.logoImage = UIImage(named: "default-logo")!
        self.payButtonProperties = PayButtonProperties()

        // Compose main elements
        uiComponentsGenerator = UIKitComponentsGenerator()
        requestGenerator = RequestGenerator()
        requestExecutor = RequestExecutor()
        resultInterpreting = ResultInterpreter()
        apiProvider = APIProvider(requestGenerator: requestGenerator, requestExecutor: requestExecutor, resultInterpretor: resultInterpreting)

        super.init(coder: coder)

        setUpSubviews()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        payButton.addTarget(self, action: #selector(pay(_:)), for: .touchUpInside)
    }

    // MARK: Subviews

    private lazy var cardDetailsView: CardDetailsView = {
        uiComponentsGenerator.makeCardDetailsView()
    }()

    private lazy var logoView: UIView = {
        uiComponentsGenerator.makeLogoView(with: logoImage)
    }()

    private lazy var payButton: UIButton = {
        uiComponentsGenerator.makePayButton(with: payButtonProperties)
    }()

    private func setUpSubviews() {
        view.addAutoLayoutSubview(logoView)
        view.addAutoLayoutSubview(cardDetailsView)
        view.addAutoLayoutSubview(payButton)

        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            logoView.heightAnchor.constraint(equalToConstant: 60),
            cardDetailsView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 44),
            cardDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            cardDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            cardDetailsView.heightAnchor.constraint(equalToConstant: 200),
            payButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            payButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: Actions
    
    @objc private func pay(_ sender: UIButton) {
        cardDetailsView.removeHighlights()

        guard let cardDetails = extractCardDetailsFromUI() else {
            return
        }

        generatePaymentToken(for: cardDetails)

    }

    func generatePaymentToken(for cardDetails: CardDetails) {
        apiProvider.generatePayment(cardDetails: cardDetails) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let token):
                self.delegate?.didGeneratePaymentToken(token, viewController: self)
            case .failure(let error):
                self.delegate?.tokenGenerationFailed(with: error)
            }
        }
    }

    // MARK: Helpers

    private func extractCardDetailsFromUI() -> CardDetails? {
        guard let cardNumber = cardDetailsView.cardNumber,
              !cardNumber.isEmpty else {
            cardDetailsView.highlightCardNumber()
            return nil
        }
        guard let holderName = cardDetailsView.holderName,
              !holderName.isEmpty else {
            cardDetailsView.highlightHolderName()
            return nil
        }
        guard let cvv = cardDetailsView.cvv,
              !cvv.isEmpty else {
            cardDetailsView.highlightCVV()
            return nil
        }
        guard let expiryMonth = cardDetailsView.expiryMonth,
              let expiryYear = cardDetailsView.expiryYear,
              let expiryDate = CardExpirationDate(month: expiryMonth, year: expiryYear) else {
            cardDetailsView.highlightExpiryDate()
            return nil
        }

        return CardDetails(number: cardNumber, name: holderName, cvv: cvv, expirationDate: expiryDate)
    }

    // MARK: Test Helpers

    // Note: This initializer is internal (the integrator cannot access it) but it can be accessed from the Tests target helping us to mock services and test functionalities.
    init(logoImage: UIImage? = nil,
         payButtonProperties: PayButtonProperties = PayButtonProperties(),
         uiComponentsGenerator: UIComponentsGenerating = UIKitComponentsGenerator(),
         requestGenerator: RequestGenerating = RequestGenerator(),
         requestExecutor: RequestExecuting = RequestExecutor(),
         resultInterpreting: ResultInterpreting = ResultInterpreter(),
         apiProvider: APIProviding) {

        self.uiComponentsGenerator = uiComponentsGenerator
        self.requestGenerator = requestGenerator
        self.requestExecutor = requestExecutor
        self.resultInterpreting = resultInterpreting
        self.apiProvider = apiProvider

        if let validLogo = logoImage {
            self.logoImage = validLogo
        } else {
            self.logoImage = UIImage(named: "default-logo", in: Bundle.module, compatibleWith: nil)!
        }
        self.payButtonProperties = payButtonProperties

        super.init(nibName: nil, bundle: nil)

        setUpSubviews()
    }
}
