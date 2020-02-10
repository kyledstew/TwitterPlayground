//
//  TwitterNetwork.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

typealias ResultHandler<T> = (Result<T, Swift.Error>) -> Void

/// `Endpoint` object that dictates how a `URLRequest` is to be performed and handled
struct Endpoint<T: Codable> {
    var router: Router
    var path: String
    var httpMethod: HTTPMethod
    var headers: [String: String]
    var responseType: T.Type
    var resultHandler: ResultHandler<T>
}

/// Object that dictates how interaction with a server is to be managed
protocol Router {
    // The host `URL` for the server
    var url: URL { get }

    // `Interceptor` object to intercept responses and handle errors accordingly
    var interceptor: Interceptor? { get }

    // `DateFormatter` object to be used when parsing `Date` objects from the server
    var dateFormatter: DateFormatter? { get }

    // Configure the `URLRequest` as needed to interact with server
    func configure(request urlRequest: URLRequest) -> URLRequest
}

extension Endpoint {
    /// Perform the network request, then call the `ResultHandler` with the response
    func perform() {
        Networking.request(endpoint: self)
    }
}

/// Object that handles the `DataTaskCompletionArgs` result
protocol Interceptor {
    func intercept<T>(args: DataTaskCompletionArgs, endpoint: Endpoint<T>, completionHandler: @escaping DataTaskCompletionHandler)
}
