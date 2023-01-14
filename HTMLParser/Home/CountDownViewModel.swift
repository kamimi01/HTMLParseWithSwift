//
//  CountDownViewModel.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2023/01/15.
//

import Foundation

class CountDownViewModel: ObservableObject {
    @Published var leftDays = "24"
    @Published var leftHours = "11"
    @Published var leftMins = "30"
    @Published var leftSec = "22"

    func startCount() {

    }
}
