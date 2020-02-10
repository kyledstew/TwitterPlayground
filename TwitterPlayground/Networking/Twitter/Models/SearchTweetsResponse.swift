//
//  SearchTweetsResponse.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    struct SearchTweetsResponse: Codable {
        var tweets: [Tweet]

        enum CodingKeys: String, CodingKey {
            case tweets = "statuses"
        }
    }

    struct Tweet: Codable {
        var id: Double
        var createdAt: Date
        var text: String
        var user: User

        enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created_at"
            case text = "full_text"
            case user
        }
    }

    struct User: Codable {
        var name: String
        var screenName: String
        var location: String
        var description: String
        var profileImageURLString: String

        enum CodingKeys: String, CodingKey {
            case name
            case screenName = "screen_name"
            case location
            case description
            case profileImageURLString = "profile_image_url_https"
        }
    }
}
