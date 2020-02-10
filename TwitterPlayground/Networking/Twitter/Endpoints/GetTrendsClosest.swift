//
//  GetTrendsClosest.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation
import CoreLocation

extension Twitter {
    static func getTrendsClosest(latitude: Double, longitude: Double, completion: @escaping (Result<TrendLocation, Swift.Error>) -> Void) -> Endpoint<[TrendLocation]> {
        let parameters: [String: String] = [
            "lat": "\(latitude)",
            "long": "\(longitude)"
        ]
        return Endpoint(router: Router(),
                        path: "1.1/trends/closest.json",
                        httpMethod: .get(parameters),
                        headers: [:],
                        responseType: [TrendLocation].self,
                        resultHandler: { result in
                            switch result {
                            case let .success(locations):
                                guard let firstLocation = locations.first else {
                                    completion(.failure(Error.noLocationAvailable))
                                    return
                                }
                                completion(.success(firstLocation))

                            case let .failure(error):
                                completion(.failure(error))
                            }
        })
    }
}

