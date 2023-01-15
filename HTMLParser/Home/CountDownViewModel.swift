//
//  CountDownViewModel.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2023/01/15.
//

import Foundation

class CountDownViewModel: ObservableObject {
    @Published var leftDays = "-"
    @Published var leftHours = "-"
    @Published var leftMins = "-"
    @Published var leftSec = "-"
    private var timer = Timer()
    private var time = 5

    func startCount() {
        // 前回のインスタンスが残っていた場合を想定して念の為削除
        timer.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.countDownUntilChrismas),
            userInfo: nil,
            repeats: true
        )
    }

    @objc private func countDownUntilChrismas() {
        let startDate = "2023-12-25"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formatedStartDate = dateFormatter.date(from: startDate)
        let currentDate = Date()

        if let leftDays = Calendar.current.dateComponents([.day], from: currentDate, to: formatedStartDate!).day {
            self.leftDays = String(leftDays)
        }
        if let leftHours = Calendar.current.dateComponents([.hour], from: currentDate, to: formatedStartDate!).hour {
            self.leftHours = String(leftHours % 24)
        }
        if let leftMins = Calendar.current.dateComponents([.minute], from: currentDate, to: formatedStartDate!).minute {
            self.leftMins = String(leftMins % 60)
        }
        if let leftSec = Calendar.current.dateComponents([.second], from: currentDate, to: formatedStartDate!).second {
            self.leftSec = String(leftSec % 60)
        }

        if self.leftDays == "0" && self.leftHours == "0" && self.leftMins == "0" && self.leftSec == "0" {
            timer.invalidate()
        }
    }
}
