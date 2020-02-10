//
//  GetTrendsResponse.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension Twitter {
    struct GetTrendsResponse: Codable {
        var trends: [Trend]
    }
}
