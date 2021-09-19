//  Created by TCode on 19/9/21.

import UIKit

extension UIStackView {

    /// Adds the views as arranged subviews in order.
    /// - Parameter views: The views to add
    public func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }

}
