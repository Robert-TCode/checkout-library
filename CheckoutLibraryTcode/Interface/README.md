Sample Checkout library using Swift and Primer's API.

Notes on distribution:
- The XCFramework, if distributed as closed source code, should be normally hosted separately on a different, public repository.
- Distribution via Carthage can be done using the new "binary" with hosted source code file.
- Distribution via SPM can be easily done with the functionality provided by GitHub (releases).

Distribution as XCFramework via Cocoapods can be done running the following methods in terminal:
- `pod spec lint CheckoutLibraryTcode.podspec`
- `pod trunk push CheckoutLibraryTcode.podspec`
