//  Created by TCode on 19/9/21.

import Foundation
import UIKit
@testable import CheckoutLibraryTcode

class MockUIComponentsGenerator: UIComponentsGenerating {

    var providedLogoImage: UIImage?
    var providedPayButtonProperties: PayButtonProperties?

    var makeLogoViewCallsCount = 0
    var makeCardDetailsViewCallsCount = 0
    var makePayButtonCallsCount = 0

    func makeLogoView(with logoImage: UIImage) -> UIView {
        providedLogoImage = logoImage
        makeLogoViewCallsCount += 1
        return UIView()
    }

    func makeCardDetailsView() -> CardDetailsView {
        makeCardDetailsViewCallsCount += 1
        return CardDetailsView()
    }

    func makePayButton(with properties: PayButtonProperties) -> UIButton {
        providedPayButtonProperties = properties
        makePayButtonCallsCount += 1
        return UIButton()
    }

}
