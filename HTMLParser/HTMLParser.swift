//
//  HTMLParser.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/25.
//

import Foundation
import SwiftSoup

class HTMLParser {
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
                    try entryElement.select("div.date")[entryIndex].text()
                }
                let name = findElementString {
                    try entryElement.select("div.user")[entryIndex].text()
                }
                let url = findElementString {
                    try entryElement.select("div.article")[entryIndex].select("div.link").first()?.text()
                }
                let linkAndTitleText = findElementString {
                    try entryElement.select("div.left")[entryIndex].text()
                }
                let title = linkAndTitleText.replacingOccurrences(of: url + " ", with: "")
                let iconImage = findElementString {
                    try entryElement.select("img")[entryIndex].attr("src")
                }

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
        } catch {

        }
        return articles
    }

    // 何か処理を行った時にエラーが投げられたら、空文字を返す
    static private func findElementString(completion: () throws -> String?) -> String {
        do {
            return try completion() ?? ""
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
}
