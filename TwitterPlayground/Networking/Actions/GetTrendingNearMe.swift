//
//  GetTrendingNearMe.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation
import PromiseKit

extension Actions {
    static func getTrendingNearMe(completion: @escaping (Swift.Result<[Twitter.Trend], Swift.Error>) -> Void) {
        getLocation()
            .then(self.getWOEID)
            .then(self.getTweets)
            .done { trends in
                completion(.success(trends))
            }.catch { error in
                completion(.failure(error))
            }
    }

    fileprivate static func getLocation() -> Promise<(latitude: Double, longitude: Double)> {
        return Promise { seal in
            Location.sharedInstance.getCurrentLocation { result in
                switch result {
                case let .success(location):
                    seal.fulfill((latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))

                case let .failure(error):
                    seal.reject(error)
                }
            }
        }
    }

    fileprivate static func getWOEID(latitude: Double, longitude: Double) -> Promise<Int> {
        return Promise { seal in
            Twitter.getTrendsClosest(latitude: latitude, longitude: longitude) { result in
                switch result {
                case let .success(location):
                    seal.fulfill(location.woeid)

                case let .failure(error):
                    seal.reject(error)
                }
            }
            .perform()
        }
    }

    fileprivate static func getTweets(woeid: Int) -> Promise<[Twitter.Trend]> {
        return Promise { seal in
            Twitter.getTrending(woeid: woeid) { result in
                switch result {
                case let .success(tweets):
                    seal.fulfill(tweets)

                case let .failure(error):
                    seal.reject(error)
                }
            }
            .perform()
        }
    }
}
