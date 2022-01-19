## Sample Checkout library using Swift and Primer's API.

Note: This is just a sample and is not meant for production usage.

### Integration Documentation

1. As the library is not distributed yet, manually adding the XCFramework to your project is necessary. 
Once distribution is done, use your dependency manager to add the Checkout Library dependency (i.e.  `pod "CheckoutLibraryTcode"`).

2. In the entry point of your application (usually `AppDelegate` or @main `AppName.swift` for SwiftUI apps), import the library and configure it as follows using your client token.

`import CheckoutLibraryTcode`
`CheckoutLibrary.configure(clientToken: clientToken)`

3. In order to generate a client token, use your API key is a request with the following formet:

```
curl --request POST \
  -H 'Content-Type: application/json' \
  -H 'X-Api-Key: "YOUR_API_KEY' \
  https://api.staging.primer.io/auth/client-token
```

Extract the client token from the result with the format:
```
{
   "clientToken":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2Nlc3NUb2tlbiI6ImYwOTZkNjMzLTM1YTgtNGE2YS05Zjg1LWQ4MWRlMTc4ZDJlNSIsImFuYWx5dGljc1VybCI6Imh0dHBzOi8vYW5hbHl0aWNzLmFwaS5zdGFnaW5nLmNvcmUucHJpbWVyLmlvL21peHBhbmVsIiwiaW50ZW50IjoiQ0hFQ0tPVVQiLCJjb25maWd1cmF0aW9uVXJsIjoiaHR0cHM6Ly9hcGkuc3RhZ2luZy5wcmltZXIuaW8vY2xpZW50LXNkay9jb25maWd1cmF0aW9uIiwiY29yZVVybCI6Imh0dHBzOi8vYXBpLnN0YWdpbmcucHJpbWVyLmlvIiwicGNpVXJsIjoiaHR0cHM6Ly9zZGsuYXBpLnN0YWdpbmcucHJpbWVyLmlvIiwiZW52IjoiU1RBR0lORyIsInRocmVlRFNlY3VyZUluaXRVcmwiOiJodHRwczovL3NvbmdiaXJkc3RhZy5jYXJkaW5hbGNvbW1lcmNlLmNvbS9jYXJkaW5hbGNydWlzZS92MS9zb25nYmlyZC5qcyIsInRocmVlRFNlY3VyZVRva2VuIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SnFkR2tpT2lJNVkyVm1ZMlZqTXkxbU5UUXhMVFEzTTJFdFlqRTNZeTA0WkdOak0yWTVOV1E0TlRVaUxDSnBZWFFpT2pFMk1qQXhNakEwTmpVc0ltbHpjeUk2SWpWbFlqVmlZV1ZqWlRabFl6Y3lObVZoTldaaVlUZGxOU0lzSWs5eVoxVnVhWFJKWkNJNklqVmxZalZpWVRReFpEUTRabUprTmpBNE9EaGlPR1UwTkNKOS52alNNUmNiTFZKbG9mckZsQ0puUlppdkc5NVprc1hqcmVnSk1JcGYtaFpzIiwicGF5bWVudEZsb3ciOiJERUZBVUxUIn0.Amc9FqCmgpJmYLn-j_h9CzttPQ7mb3JaaSMQVo1QUSs",
   "expirationDate":"2021-05-05T09:27:45.334383"
}
```

4. For presenting the checkout view, instantiate a `CheckoutViewController`. You may want to customize the appearances of the checkout view by passing a logo or specific properties for the Pay button.

```
let checkoutViewController = CheckoutViewController(logoImage: yourImage, payButtonProperties: yourPayButtonProperties)
```

5. Add a `CheckoutViewControllerDelegate` to be notifiec when a payment token generation has succeeded or failed.

```
class CheckoutDelegate: CheckoutViewControllerDelegate {
    func didGeneratePaymentToken(_ token: String, viewController: CheckoutViewController) {
        // ...
    }

    func tokenGenerationFailed(with error: Error) {
        // ...
    }
}
```

```
checkoutViewController.delegate = CheckoutDelegate()

```


### Distribution

Notes on distribution:
- The XCFramework, if distributed as closed source code, should be normally hosted separately on a different, public repository.
- Distribution via Carthage can be done using the new "binary" with hosted source code file.
- Distribution via SPM can be easily done with the functionality provided by GitHub (releases).

Distribution as XCFramework via Cocoapods can be done running the following methods in terminal after the XCFramework was uploaded on a public repo.
- `pod spec lint CheckoutLibraryTcode.podspec`
- `pod trunk push CheckoutLibraryTcode.podspec`


### What could be improved further

- Refine architecture around the `CardView` UI by using a `CardNumberTextFieldHandler` instead of `CardNumberTextFieldDelegate`, that would itself have the properties of returning the `cardType` and other useful information, as well as processing the validity of the input. This would then remove one layer of complexity and keep the logic better separated.
- Add the possibility to customise further the UI in the `CheckoutViewController` with some predefined background/card types.
- See other comments in the codebase
