//
//  GetTrending.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    static func getTrending(woeid: Int, completion: @escaping (Result<[Trend], Swift.Error>) -> Void) -> Endpoint<[GetTrendsResponse]> {
        return Endpoint(router: Router(),
                 path: "1.1/trends/place.json",
                 httpMethod: .get(["id": "\(woeid)"]),
                 headers: [:],
                 responseType: [GetTrendsResponse].self,
                 resultHandler: { result in
                    switch result {
                    case let .success(data):
                        completion(.success(data.flatMap { $0.trends }))

                    case let .failure(error):
                        completion(.failure(error))
                    }
        })
    }
}
