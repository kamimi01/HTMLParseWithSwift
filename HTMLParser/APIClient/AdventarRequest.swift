//
//  AdventarRequest.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/20.
//

import Foundation

protocol AdventarRequest {
    associatedtype Response = [Article]

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

extension AdventarRequest {
    var baseURL: URL {
        return URL(string: "https://adventar.org/calendars")!
    }

    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }

    func response(from data: Data) -> [Article] {
        // SwiftSoupを使って解析する
        guard let htmlString = String(data: data, encoding: .utf8) else {
            return [Article]()
        }

        return HTMLParser.parse(htmlString: htmlString)
    }
}
