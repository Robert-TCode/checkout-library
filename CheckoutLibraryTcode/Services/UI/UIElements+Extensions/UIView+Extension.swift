//  Created by TCode on 19/9/21.

import UIKit

extension UIView {

    /// Pins the receiver to the superview's edge anchors.
    public func pinToSuperview() {
        guard let superview = superview else {
            assertionFailure("No superview")
            return
        }

        pin(to: superview)
    }

    /// Pins the receiver to the specified view's edge anchors.
    /// - Parameter to: The view to pin to.
    public func pin(to: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: to.leadingAnchor),
            topAnchor.constraint(equalTo: to.topAnchor),
            trailingAnchor.constraint(equalTo: to.trailingAnchor),
            bottomAnchor.constraint(equalTo: to.bottomAnchor)
        ])
    }

    /// Pins the receiver to the superview's layout margins.
    public func pinToLayoutMarginsOfSuperview() {
        guard let superview = superview else {
            assertionFailure("No superview")
            return
        }

        pinToLayoutMargins(of: superview)
    }

    /// Pins the receiver to the specified view's layout margins.
    /// - Parameter view: The view to pin to.
    public func pinToLayoutMargins(of view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }

    /// Adds a subview after setting `translatesAutoresizingMaskIntoConstraints` to `false`.
    /// - Parameter view: The subview to add.
    public func addAutoLayoutSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
