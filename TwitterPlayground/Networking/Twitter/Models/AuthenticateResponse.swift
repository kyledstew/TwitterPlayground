//
//  AuthenticateResponse.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    struct AuthenticateResponse: Codable {
        var tokenType: String
        var accessToken: String

        enum CodingKeys: String, CodingKey {
            case tokenType = "token_type"
            case accessToken = "access_token"
        }
    }
}
