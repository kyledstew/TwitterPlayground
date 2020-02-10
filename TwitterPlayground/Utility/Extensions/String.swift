//
//  String.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension String {
    var base64Encoded: String {
        return self.data(using: .utf8)!.base64EncodedString()
    }
}
