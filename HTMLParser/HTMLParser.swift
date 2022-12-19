//
//  HTMLParser.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/17.
//

import Foundation
import SwiftSoup

class HTMLParser: ObservableObject {
    @Published var text = ""
    @Published var errorMessage = ""
    private var articles = [Article]()

    func parser() {
        do {
//            let html = "<html><head><title>First parse</title></head>"
//            + "<body><p>Parsed HTML into a doc.</p></body></html>"
            guard let htmlURL = Bundle.main.url(forResource: "adventar", withExtension: "html"),
                  let htmlString = try? String(contentsOf: htmlURL) else {
                return
            }

            let doc: Document = try SwiftSoup.parse(htmlString)
            guard let entryElement = try doc.select("ul.EntryList").first() else {
                return
            }

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

                let article = Article(date: date, name: name, url: url, title: title, iconImage: iconImage)
                articles.append(article)
                print(articles)

                text = date
            }

        } catch Exception.Error(let type, let message) {
            print(type)
            print(message)
            errorMessage = message
        } catch {
            print("error")
            errorMessage = "Unexpected Error"
        }
    }
}
