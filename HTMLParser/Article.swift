//
//  Article.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/19.
//

import Foundation

struct Article: Identifiable {
    let id = UUID().uuidString
    let date: String
    let name: String
    let url: String
    let title: String
    let iconImage: String
}
