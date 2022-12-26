//
//  HTMLParser.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/17.
//

import Foundation
import SwiftSoup

enum RetreiveStatus {
    case empty
    case loading
    case exist
    case error
}

class AdventarViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var searchKeyword = ""
    @Published var retreiveStatsu = RetreiveStatus.empty

    func getArticles() {
        retreiveStatsu = .loading
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
                if response.count == 0 {
                    DispatchQueue.main.async {
                        self.retreiveStatsu = .empty
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.retreiveStatsu = .exist
                    self.articles = response
                }
            case .failure(let error):
                self.retreiveStatsu = .error
                print(error.localizedDescription)
            }
        }
    }
}
