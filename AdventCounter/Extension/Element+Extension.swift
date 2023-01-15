//
//  Array+Extension.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/25.
//

import Foundation
import SwiftSoup

extension Elements {
    subscript (safe index: Index) -> Element? {
        if indices.contains(index) {
            return self[index]
        }
        print("index out of range, so retrun nil")
        return nil
    }
}
