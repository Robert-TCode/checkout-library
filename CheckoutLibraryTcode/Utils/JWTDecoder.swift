//  Created by TCode on 19/9/21.

import Foundation

class JWTDecoder {

    static func decode(jwtToken jwt: String) -> [String: Any] {
        let segments = jwt.components(separatedBy: ".")
        if segments.count < 2 {
            CheckoutLogger.log(level: .error, message: "Provided JWT doesn't have the expected format")
            return [:]
        }
        return decodeJWTPart(segments[1]) ?? [:]
    }

    static func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
              let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
            return nil
        }

        return payload
    }

    static func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value.replacingOccurrences(of: "-", with: "+")
                          .replacingOccurrences(of: "_", with: "/")

        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length

        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 += padding
        }

        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
}
