//
//  Trend.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    struct Trend: Codable {
        var name: String
        var url: String
        var tweetVolume: Int?

        enum CodingKeys: String, CodingKey {
            case name
            case url
            case tweetVolume = "tweet_volume"
        }
    }
}
