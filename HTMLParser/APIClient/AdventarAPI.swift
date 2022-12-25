//
//  AdventarAPI.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/20.
//

import Foundation

class AdventarAPI {
    struct GetCalendars: AdventarRequest {
        let keyword: String

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return keyword
        }
    }
}
