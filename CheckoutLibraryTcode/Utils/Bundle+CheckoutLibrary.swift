//  Created by TCode on 19/9/21.

import Foundation

// MARK: - Swift Bundle Accessor

private class BundleFinder {}

extension Foundation.Bundle {

    /// A bundle for the CheckoutLibrary application
    static let module: Bundle = Bundle(for: BundleFinder.self)
}
