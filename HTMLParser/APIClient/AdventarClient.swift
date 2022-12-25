//
//  AdventarClient.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/22.
//

import Foundation

class AdventarClient {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func send<Request: AdventarRequest>(
        request: Request,
        completion: @escaping (Result<[Article], AdventarClientError>) -> Void
    ) {
        let urlRequest = request.buildURLRequest()

        httpClient.sendRequest(urlRequest) { result in
            switch result {
            case .success((let data, _)):
                let response = request.response(from: data)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(.connectionError(error)))
            }
        }
    }
}
