//
//  SearchTweets.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    static func searchTweets(keyword: String, completion: @escaping (Result<[Tweet], Swift.Error>) -> Void) -> Endpoint<SearchTweetsResponse> {
        let parameters = ["q": keyword,
                          "tweet_mode": "extended",
                          "result_type": "popular"]
        return Endpoint(router: Router(),
                 path: "1.1/search/tweets.json",
                 httpMethod: .get(parameters),
                 headers: [:],
                 responseType: SearchTweetsResponse.self,
                 resultHandler: { result in
                    switch result {
                    case let .success(data):
                        completion(.success(data.tweets))

                    case let .failure(error):
                        completion(.failure(error))

                    }
        })
    }
}

