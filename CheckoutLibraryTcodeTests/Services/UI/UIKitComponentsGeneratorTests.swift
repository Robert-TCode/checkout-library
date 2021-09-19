//  Created by TCode on 19/9/21.

import Foundation
import XCTest
@testable import CheckoutLibraryTcode

class UIKitComponentsGeneratorTests: XCTestCase {

    let sut = UIKitComponentsGenerator()

    func test_makeLogoWithImage_rendersProperView() {
        let image = UIImage.init(systemName: "heart.fill")!
        let logoView = sut.makeLogoView(with: image)

        let imageSubview = logoView.subviews.first as? UIImageView

        XCTAssertNotNil(imageSubview)
        XCTAssertEqual(imageSubview?.image, image)
        XCTAssertEqual(imageSubview!.contentMode, UIView.ContentMode.scaleAspectFit)
    }

    func test_makePayButton_rendersProperView() {
        let payButtonProperties = PayButtonProperties(size: CGSize(width: 40, height: 40),
                                                      color: .blue,
                                                      cornerRadius: 5,
                                                      font: UIFont.boldSystemFont(ofSize: 20),
                                                      fontSize: 12,
                                                      fontWeight: .medium,
                                                      fontColor: .red)
        let payButton = sut.makePayButton(with: payButtonProperties)

        XCTAssertEqual(payButton.frame.size, payButtonProperties.size)
        XCTAssertEqual(payButton.backgroundColor, payButtonProperties.color)
        XCTAssertEqual(payButton.layer.cornerRadius, payButtonProperties.cornerRadius)
        XCTAssertEqual(payButton.currentTitle, "Pay")
        XCTAssertEqual(payButton.titleLabel?.font, payButtonProperties.font)
        XCTAssertTrue(payButton.titleLabel!.adjustsFontSizeToFitWidth)
        XCTAssertTrue(payButton.titleLabel!.adjustsFontForContentSizeCategory)
    }
}
