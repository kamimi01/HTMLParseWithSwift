//
//  HTMLParser.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/17.
//

import Foundation
import SwiftSoup

class AdventarViewModel: ObservableObject {
    @Published var text = ""
    @Published var errorMessage = ""
    private var articles = [Article]()

    func getArticles() {
        // APIクライアントの作成
        let client = AdventarClient(httpClient: URLSession.shared)

        // リクエストの発行
        let request = AdventarAPI.GetCalendars(keyword: "7577")

        // リクエストの送信
        client.send(request: request) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
