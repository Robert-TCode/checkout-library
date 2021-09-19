//  Created by TCode on 14/9/21.

import Foundation
import UIKit

/// Pay button visual attributes.
public struct PayButtonProperties {

    var size: CGSize
    var color: UIColor
    var cornerRadius: CGFloat

    var font: UIFont
    var fontSize: CGFloat
    var fontWeight: UIFont.Weight
    var fontColor: UIColor

    /// Initializes the custom UI for the Pay button of the `CheckoutViewController`.
    /// - Parameters:
    ///   - size: The size of the button.
    ///   - color: The size of the button.
    ///   - cornerRadius: The corner radius value for button's edges.
    ///   - font: The font used for the button's title.
    ///   - fontSize: The font size used for the button's title.
    ///   - fontWeight: The weight of the font used for the button's title.
    ///   - fontColor: The color of the button's title.
    public init(size: CGSize = CGSize(width: 120, height: 44),
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
