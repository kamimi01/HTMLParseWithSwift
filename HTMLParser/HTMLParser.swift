//
//  HTMLParser.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/25.
//

import Foundation
import SwiftSoup

struct HTMLParser {
    /// 文字列をパースして記事の配列を作成する
    /// - Parameter htmlString: HTMLの文字列
    /// - Returns: 記事の配列
    static func parse(htmlString: String) -> [Article] {
        var articles = [Article]()
        do {
            let doc: Document = try SwiftSoup.parse(htmlString)
            let entries = try doc.select("ul.EntryList").select("li.item")
            let numOfEntries = entries.count
            if numOfEntries == 0 {
                return articles
            }

            for entryIndex in 0..<(numOfEntries - 1) {
                let date = findElementString {
                    try entries[safe: entryIndex]?.select("div.date").text()
                }
                let name = findElementString {
                    try entries[safe: entryIndex]?.select("div.user").text()
                }
                let url = findElementString {
                    try entries[safe: entryIndex]?.select("div.article").select("div.link").first()?.text()
                }
                let title = findElementString {
                    let leftHTMLElements = try entries[safe: entryIndex]?.select("div.left")
                    let leftHTMLString = try leftHTMLElements?.html() ?? ""
                    return try SwiftSoup.parse(leftHTMLString).select("div")[safe: 1]?.text()
                }
                let comment = findElementString {
                    try entries[safe: entryIndex]?.select("div.comment").text()
                }
                let iconImage = findElementString {
                    try entries[safe: entryIndex]?.select("div.user").select("img").attr("src")
                }

                let article = Article(
                    date: date,
                    name: name,
                    url: url,
                    title: title.isEmpty ? comment : title,
                    iconImage: iconImage
                )
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
