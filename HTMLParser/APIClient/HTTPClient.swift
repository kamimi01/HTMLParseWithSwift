//
//  HTTPClient.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/21.
//

import Foundation

protocol HTTPClient {
    func sendRequest(
        _ urlRequest: URLRequest,
        completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
    )
}

extension URLSession: HTTPClient {
    func sendRequest(
        _ urlRequest: URLRequest,
        completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
    ) {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                completion(.failure(error))
            case (let data?, let urlResponse as HTTPURLResponse, _):
                completion(.success((data, urlResponse)))
            default:
                fatalError("invalid response combinationn \(String(describing:  (data, urlResponse, error))).")
            }
        }
        task.resume()
    }
}
