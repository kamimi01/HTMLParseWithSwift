//
//  AdventarRequest.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/20.
//

import Foundation
import SwiftSoup

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

    func response(from data: Data) throws -> [Article] {
        // SwiftSoupを使って解析する
        guard let htmlString = String(data: data, encoding: .utf8) else {
            return [Article]()
        }

        let doc: Document = try SwiftSoup.parse(htmlString)
        guard let entryElement = try doc.select("ul.EntryList").first() else {
            return [Article]()
        }

        var articles = [Article]()
        let numOfEntry = 25
        for entryIndex in 0..<(numOfEntry - 1) {
            let date = try entryElement.select("div.date")[entryIndex].text()
            let name = try entryElement.select("div.user")[entryIndex].text()
            let optionalStringURL = try entryElement.select("div.article")[entryIndex].select("div.link").first()?.text()
            var url: String {
                guard let optionalString = optionalStringURL else {
                    return ""
                }
                return optionalString
            }
            let linkAndTitleText = try entryElement.select("div.left")[entryIndex].text()
            var title = linkAndTitleText.replacingOccurrences(of: url + " ", with: "")
            let iconImage = try entryElement.select("img")[entryIndex].attr("src")

            print(date)
            print(name)
            print(url)
            print(title)
            print(iconImage)

            let article = Article()
            article.date = date
            article.name = name
            article.url = url
            article.title = title
            article.iconImage = iconImage

            articles.append(article)
            print(articles)
        }

        return articles
    }
}
