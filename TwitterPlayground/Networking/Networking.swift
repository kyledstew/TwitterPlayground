//
//  Networking.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case get([String: Any])
    case post(Data?)
}

typealias DataTaskCompletionArgs = (Data?, URLResponse?, Swift.Error?)
typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void

struct Networking {
    enum Error: Swift.Error {
        case noDataNoError
        case unableToParseData(Swift.Error)
    }

    static func request<T>(endpoint: Endpoint<T>) {
        let url = endpoint.router.url.appendingPathComponent(endpoint.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = endpoint.headers
        urlRequest = endpoint.router.configure(request: urlRequest)

        switch endpoint.httpMethod {
        case let .get(parameters):
            urlRequest.httpMethod = "GET"
            urlRequest.url?.attachParameters(parameters)

        case let .post(data):
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = data
        }

        let dataTask = URLSession.shared.dataTask(with: urlRequest, endpoint: endpoint) { data, response, error in
            guard let data = data else {
                endpoint.resultHandler(.failure(error ?? Error.noDataNoError ))
                return
            }

            let decoder = JSONDecoder()
            if let dateFormatter = endpoint.router.dateFormatter {
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
            }
            do {
                let parsedData = try decoder.decode(endpoint.responseType.self, from: data)
                endpoint.resultHandler(.success(parsedData))
            } catch {
                endpoint.resultHandler(.failure(Error.unableToParseData(error)))
            }
        }
        dataTask.resume()
    }
}

fileprivate extension URLSession {
    func dataTask<T>(with urlRequest: URLRequest, endpoint: Endpoint<T>, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask {
        return dataTask(with: urlRequest) { data, response, error in
            if let interceptor = endpoint.router.interceptor {
                interceptor.intercept(args: (data, response, error),
                                      endpoint: endpoint,
                                      completionHandler: completionHandler)
            } else {
                completionHandler(data, response, error)
            }
        }
    }
}
