//
//  Authenticate.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    static func authenticate(completion: @escaping (Result<AuthenticateResponse, Swift.Error>) -> Void) -> Endpoint<AuthenticateResponse> {
        let creds = Constants.apiKey + ":" + Constants.apiSecretKey
        return Endpoint(router: Router(),
                        path: "oauth2/token",
                        httpMethod: .post("grant_type=client_credentials".data(using: .utf8)),
                        headers: ["Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
                                  "Authorization":"Basic \(creds.base64Encoded)"],
                        responseType: AuthenticateResponse.self,
                        resultHandler: completion)
    }
}
