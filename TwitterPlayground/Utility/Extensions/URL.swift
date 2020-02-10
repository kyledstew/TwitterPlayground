//
//  URL.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

extension URL {
    mutating func attachParameters(_ parameters: [String: Any]) {
        guard !parameters.isEmpty else { return }
        let path = self.absoluteString + "?" + parameters.compactMap { "\($0.key)=\("\($0.value)".addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)" }.joined(separator: "&")
        self = URL(string: path)!
    }
}
