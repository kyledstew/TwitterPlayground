//
//  Constants.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    struct Constants {
        static let hostURL: URL = URL(string: "https://api.twitter.com")!
        static let apiKey: String = "l7JIgU9YfhTTS1uzoGVWinHQI"
        static let apiSecretKey: String = "256K3ta7dEfi0VQueVmZYpeDqREvn1ZFdOM6TnsiBV5Kg5BE3c"

        fileprivate static var accessTokenKey: String = "TwitterPlayground.Twitter.accessToken"
        static var accessToken: String? {
            get {
                return UserDefaults.standard.string(forKey: accessTokenKey)
            }

            set {
                UserDefaults.standard.set(newValue, forKey: accessTokenKey)
            }
        }
    }
}
