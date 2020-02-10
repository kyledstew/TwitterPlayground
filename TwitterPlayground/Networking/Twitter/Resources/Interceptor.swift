//
//  Interceptor.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    struct Interceptor: TwitterPlayground.Interceptor {
        func intercept<T>(args: DataTaskCompletionArgs, endpoint: Endpoint<T>, completionHandler: @escaping DataTaskCompletionHandler) where T : Decodable, T : Encodable {
            let (data, response, error) = args

            switch (response as? HTTPURLResponse)?.statusCode {
            case 400, 401:
                Twitter.authenticate { result in
                    switch result {
                    case let .success(credsData):
                        Constants.accessToken = credsData.accessToken
                        endpoint.perform()

                    case let .failure(error):
                        completionHandler(data, response, error)
                    }
                }
                .perform()

            default:
                completionHandler(data, response, error)
            }
        }
    }
}
