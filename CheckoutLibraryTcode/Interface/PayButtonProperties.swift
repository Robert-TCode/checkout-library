//  Created by TCode on 14/9/21.

import Foundation
import UIKit

/// Pay button visual attributes.
@objc public class PayButtonProperties: NSObject {

    var size: CGSize
    var color: UIColor
    var cornerRadius: CGFloat

    var font: UIFont
    var fontSize: CGFloat
    var fontWeight: UIFont.Weight
    var fontColor: UIColor

    // Note: There are 2 different initializers (one without parameters and one with parameters)
    // instead of a single one with default values for optional parameters
    // because when the Swift interface of the XCFramework is created, the initializer is modified
    // and a run-time error saying the initializer is not implemented is being produced.
    // Same thing happens with the CheckoutViewController.

    /// Initializes the custom UI for the Pay button of the `CheckoutViewController`.
    @objc public override init() {
        self.size = CGSize(width: 120, height: 44)
        self.color = .black
        self.cornerRadius = 8
        self.font = UIFont(name: "HelveticaNeue-Medium", size: 17)!
        self.fontSize = 16
        self.fontWeight = .medium
        self.fontColor = .white
        super.init()
    }

    /// Initializes the custom UI for the Pay button of the `CheckoutViewController`.
    /// - Parameters:
    ///   - size: The size of the button.
    ///   - color: The size of the button.
    ///   - cornerRadius: The corner radius value for button's edges.
    ///   - font: The font used for the button's title.
    ///   - fontSize: The font size used for the button's title.
    ///   - fontWeight: The weight of the font used for the button's title.
    ///   - fontColor: The color of the button's title.
    @objc public init(size: CGSize = CGSize(width: 120, height: 44),
                      color: UIColor = .black,
                      cornerRadius: CGFloat = 8,
                      font: UIFont = UIFont(name: "HelveticaNeue-Medium", size: 17)!,
                      fontSize: CGFloat = 16,
                      fontWeight: UIFont.Weight = .medium,
                      fontColor: UIColor = .white) {
        self.size = size
        self.color = color
        self.cornerRadius = cornerRadius
        self.font = font
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.fontColor = fontColor
    }
}
