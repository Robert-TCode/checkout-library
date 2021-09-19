//  Created by TCode on 19/9/21.

import UIKit

protocol UIComponentsGenerating {
    func makeLogoView(with logoImage: UIImage) -> UIView
    func makeCardDetailsView() -> CardDetailsView
    func makePayButton(with properties: PayButtonProperties) -> UIButton
}

class UIKitComponentsGenerator: UIComponentsGenerating {

    func makeLogoView(with logoImage: UIImage) -> UIView {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false

        logo.image = logoImage
        logo.contentMode = .scaleAspectFit

        let logoView = UIImageView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(logo)
        logo.pinToSuperview()

        return logoView
    }

    func makeCardDetailsView() -> CardDetailsView {
        let cardDetailsView = CardDetailsView(frame: .zero, template: .curve(DesignSystem.color1,
                                                                             DesignSystem.color2,
                                                                             DesignSystem.color3,
                                                                             DesignSystem.color4,
                                                                             DesignSystem.color5))
        cardDetailsView.translatesAutoresizingMaskIntoConstraints = false

        return cardDetailsView
    }

    func makePayButton(with properties: PayButtonProperties) -> UIButton {
        let button = UIButton(frame: .zero)
        button.frame = CGRect(origin: .zero, size: properties.size)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.backgroundColor = properties.color
        button.layer.cornerRadius = properties.cornerRadius

        let title = NSLocalizedString("Pay", comment: "Pay button title")
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = properties.font
        button.titleLabel?.textColor = properties.fontColor

        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.adjustsFontForContentSizeCategory = true

        return button
    }
}
