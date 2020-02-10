//
//  SearchTweeets.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Actions {
    static func searchTweets(keyword: String, completion: @escaping (Result<[Twitter.Tweet], Error>) -> Void) {
        Twitter.searchTweets(keyword: keyword, completion: completion)
            .perform()
    }
}
