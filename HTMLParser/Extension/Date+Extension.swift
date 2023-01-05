//
//  Date+Extension.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/26.
//

import Foundation

extension TimeZone {
    static let japan = TimeZone(identifier: "Asia/Tokyo")!
}

extension Locale {
    static let japan = Locale(identifier: "ja_JP")
}

extension Date {
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .japan
        calendar.locale   = .japan
        return calendar
    }
}
