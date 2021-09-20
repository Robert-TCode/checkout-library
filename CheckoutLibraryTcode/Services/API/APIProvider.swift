//  Created by TCode on 14/9/21.

import Foundation

/// A protocol providing a method of generating single use payment tokens.
protocol APIProviding {

    typealias PaymentTokenResult = Result<String, Error>

    /// Generates a token using the provided payment method.
    /// - Parameters:
    ///   - cardDetails: The card details used for the payment.
    ///   - completion: A completion returning an optional token and an optiona error in case the generation fails.
    func generatePayment(cardDetails: CardDetails, completion: @escaping (PaymentTokenResult) -> Void)
}

/// A concrete implementation of `APIProviding` using Primer's API.
class APIProvider: APIProviding {

    // POST
    let paymentInstrumentsPath = "payment-instruments"

    var accessToken: String? {
        CheckoutLibrary.getAccessToken()
    }
    
    let requestGenerator: RequestGenerating
    let requestExecutor: RequestExecuting
    let resultInterpretor: ResultInterpreting

    init(requestGenerator: RequestGenerating,
         requestExecutor: RequestExecuting,
         resultInterpretor: ResultInterpreting) {
        self.requestGenerator = requestGenerator
        self.requestExecutor = requestExecutor
        self.resultInterpretor = resultInterpretor
    }

    func generatePayment(cardDetails: CardDetails, completion: @escaping (PaymentTokenResult) -> Void) {
        let paymentInstrument: [String: Any] = ["number": cardDetails.number,
                                                "cvv": cardDetails.cvv,
                                                "expirationMonth": cardDetails.expirationDate.monthString,
                                                "expirationYear": cardDetails.expirationDate.yearString,
                                                "cardholderName": cardDetails.name]
        guard let request = requestGenerator.makePOST(path: paymentInstrumentsPath,
                                                      token: accessToken,
                                                      parameters: ["paymentInstrument": paymentInstrument]) else {
            completion(.failure(NetworkError.noAccessToken.descriptiveError))
            return
        }

        requestExecutor.executeRequest(request) { [weak self] result in
            guard let self = self else {
                return
            }

            self.resultInterpretor.handleResult(result, model: PaymentInstrument.self) { result in
                switch result {
                case .success(let paymentInstrument):
                    completion(.success(paymentInstrument.token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

}
