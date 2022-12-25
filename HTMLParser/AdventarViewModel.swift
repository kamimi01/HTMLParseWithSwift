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
    @Published var articles = [Article]()

    func getArticles() {
        // APIクライアントの作成
        let client = AdventarClient(httpClient: URLSession.shared)

        // リクエストの発行
        let request = AdventarAPI.GetCalendars(keyword: "7632")

        // リクエストの送信
        client.send(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response)
                DispatchQueue.main.async {
                    self.articles = response
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
