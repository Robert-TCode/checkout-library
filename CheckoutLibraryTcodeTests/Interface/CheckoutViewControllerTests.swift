//  Created by TCode on 19/9/21.

import Foundation
import XCTest
import UIKit
@testable import CheckoutLibraryTcode

class CheckoutViewControllerTests: XCTestCase {

    private var mockUIComponentsGenerator: MockUIComponentsGenerator!
    private var mockRequestGenerator: MockRequestGenerator!
    private var mockRequestExecutor: MockRequestExecutor!
    private var mockResultInterpreter: MockResultInterpreter!
    private var mockAPIProvider: MockAPIProvider!

    override func setUp() {
        super.setUp()

        mockUIComponentsGenerator = MockUIComponentsGenerator()
        mockRequestGenerator = MockRequestGenerator()
        mockRequestExecutor = MockRequestExecutor()
        mockResultInterpreter = MockResultInterpreter()
        mockAPIProvider = MockAPIProvider()
    }

    override  func tearDown() {
        super.tearDown()

        mockUIComponentsGenerator = nil
        mockRequestGenerator = nil
        mockRequestExecutor = nil
        mockResultInterpreter = nil
        mockAPIProvider = nil
    }

    func test_initWithoutLogo_usesDefaultLogo() {
        _ = CheckoutViewController(uiComponentsGenerator: mockUIComponentsGenerator,
                                   requestGenerator: mockRequestGenerator,
                                   requestExecutor: mockRequestExecutor,
                                   resultInterpreting: mockResultInterpreter,
                                   apiProvider: mockAPIProvider)

        let defaultImage = UIImage(named: "default-logo", in: Bundle.module, compatibleWith: nil)
        XCTAssertEqual(mockUIComponentsGenerator.providedLogoImage, defaultImage)
    }

    func test_initWithLogo_usesProvidedLogo() {
        let image = UIImage.init(systemName: "heart.fill")
        _ = CheckoutViewController(logoImage: image,
                                   uiComponentsGenerator: mockUIComponentsGenerator,
                                   requestGenerator: mockRequestGenerator,
                                   requestExecutor: mockRequestExecutor,
                                   resultInterpreting: mockResultInterpreter,
                                   apiProvider: mockAPIProvider)

        XCTAssertEqual(mockUIComponentsGenerator.providedLogoImage, image)
    }

    func test_initWithPayButtonProperties_usesProvidedProperties() {
        let payButtonProperties = PayButtonProperties(size: CGSize(width: 40, height: 40),
                                                      color: .blue,
                                                      cornerRadius: 5,
                                                      font: UIFont.boldSystemFont(ofSize: 20),
                                                      fontSize: 12,
                                                      fontWeight: .medium,
                                                      fontColor: .red)

        _ = CheckoutViewController(payButtonProperties: payButtonProperties,
                                   uiComponentsGenerator: mockUIComponentsGenerator,
                                   requestGenerator: mockRequestGenerator,
                                   requestExecutor: mockRequestExecutor,
                                   resultInterpreting: mockResultInterpreter,
                                   apiProvider: mockAPIProvider)
        XCTAssertEqual(mockUIComponentsGenerator.providedPayButtonProperties, payButtonProperties)
    }

    func test_paymentSucceeds_callDelegateMethod() {
        let mockDelegate = MockCheckoutViewControllerDelegate()
        let sut = CheckoutViewController(apiProvider: mockAPIProvider)
        sut.delegate = mockDelegate

        let generatedToken = "test-generated-token"
        mockAPIProvider.paymentTokenToBeReturned = .success(generatedToken)
        sut.generatePaymentToken(for: TestConstants.testCardDetails)

        XCTAssertEqual(mockDelegate.lastGeneratedToken, generatedToken)
        XCTAssertEqual(mockDelegate.didGeneratePaymentTokenCallsCount, 1)
        XCTAssertNil(mockDelegate.lastGeneratedError)
    }

    func test_paymentFails_callDelegateMethods() {
        let mockDelegate = MockCheckoutViewControllerDelegate()
        let sut = CheckoutViewController(apiProvider: mockAPIProvider)
        sut.delegate = mockDelegate

        mockAPIProvider.paymentTokenToBeReturned = .failure(TestConstants.testError)
        sut.generatePaymentToken(for: TestConstants.testCardDetails)

        XCTAssertEqual(mockDelegate.lastGeneratedError!.localizedDescription, TestConstants.testError.localizedDescription)
        XCTAssertEqual(mockDelegate.tokenGenerationFailedCallsCount, 1)
        XCTAssertNil(mockDelegate.lastGeneratedToken)
    }
}

extension PayButtonProperties: Equatable {

    public static func == (lhs: PayButtonProperties, rhs: PayButtonProperties) -> Bool {
        return lhs.color == rhs.color &&
        lhs.size == rhs.size &&
        lhs.cornerRadius == rhs.cornerRadius &&
        lhs.font == rhs.font &&
        lhs.fontSize == rhs.fontSize &&
        lhs.fontWeight == rhs.fontWeight &&
        lhs.fontColor == rhs.fontColor
    }
}
