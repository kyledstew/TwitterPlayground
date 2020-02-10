//
//  Router.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    struct Router: TwitterPlayground.Router {
        var url: URL { return Twitter.Constants.hostURL }
        var interceptor: TwitterPlayground.Interceptor? = Interceptor()
        var dateFormatter: DateFormatter? = {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
            return formatter
        }()

        func configure(request urlRequest: URLRequest) -> URLRequest {
            var urlRequest = urlRequest

            if let accessToken = Twitter.Constants.accessToken {
                urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } else {
                urlRequest.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            }

            return urlRequest
        }
    }
}
