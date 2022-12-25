//
//  AdventarClientError.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/20.
//

import Foundation

enum AdventarClientError: Error {
    // 通信に失敗
    case connectionError(Error)

    // レスポンスの解釈に失敗
    case responseParseError(Error)

    // 想定外のエラー（ADVENTARはjsonで返すAPIではないので念の為これを返す）
    case unexpectedError(Error)
}
