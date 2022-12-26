//
//  HTMLParser.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/17.
//

import Foundation
import SwiftSoup

class AdventarViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var searchKeyword = ""

    func getArticles() {
        // APIクライアントの作成
        let client = AdventarClient(httpClient: URLSession.shared)

        // リクエストの発行
        if searchKeyword.isEmpty { return }
        let request = AdventarAPI.GetCalendars(keyword: searchKeyword)

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
