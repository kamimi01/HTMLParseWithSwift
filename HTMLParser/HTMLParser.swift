//
//  HTMLParser.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/25.
//

import Foundation
import SwiftSoup

class HTMLParser {
    /// 文字列をパースして記事の配列を作成する
    /// - Parameter htmlString: HTMLの文字列
    /// - Returns: 記事の配列
    static func parse(htmlString: String) -> [Article] {
        var articles = [Article]()
        do {
            let doc: Document = try SwiftSoup.parse(htmlString)
            guard let entryElement = try doc.select("ul.EntryList").first() else {
                return [Article]()
            }

            let numOfEntry = 25
            for entryIndex in 0..<(numOfEntry - 1) {
                let date = findElementString {
                    try entryElement.select("div.date")[safe: entryIndex]?.text()
                }
                let name = findElementString {
                    try entryElement.select("div.user")[safe: entryIndex]?.text()
                }
                let url = findElementString {
                    try entryElement.select("div.article")[safe: entryIndex]?.select("div.link").first()?.text()
                }
                let linkAndTitleText = findElementString {
                    try entryElement.select("div.left")[safe: entryIndex]?.text()
                }
                let title = linkAndTitleText.replacingOccurrences(of: url + " ", with: "")
                let iconImage = findElementString {
                    try entryElement.select("img")[safe: entryIndex]?.attr("src")
                }

                let article = Article()
                article.date = date
                article.name = name
                article.url = url
                article.title = title
                article.iconImage = iconImage

                articles.append(article)
            }
        } catch {
            print("failed to parse. cannot parse to Document or cannot find EntryList element: \(error.localizedDescription)")
        }
        return articles
    }

    /// パースに失敗した文字列を返す
    /// - Parameter completion: 文字列を返すSwiftSoupのメソッド
    /// - Returns: パースした文字列。失敗した場合は空文字を返す
    static private func findElementString(completion: () throws -> String?) -> String {
        do {
            guard let parsedString = try completion() else {
                print("failed to parse: string is nil so return empty string")
                return ""
            }
            return parsedString
        } catch {
            print("failed to parse: \(error.localizedDescription)")
            return ""
        }
    }
}
