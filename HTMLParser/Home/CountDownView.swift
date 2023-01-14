//
//  CountDownView.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2023/01/06.
//

import SwiftUI

/// 12/25までのカウントダウンを行う
struct CountDownView: View {
    @ObservedObject var viewModel = CountDownViewModel()
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            VStack(alignment: .center, spacing: 5) {
                Text(viewModel.leftDays)
                    .font(.title)
                Text("days")
                    .foregroundColor(.gray)
            }
            VStack(alignment: .center, spacing: 5) {
                Text(viewModel.leftHours)
                    .font(.title)
                Text("hours")
                    .foregroundColor(.gray)
            }
            VStack(alignment: .center, spacing: 5) {
                Text(viewModel.leftMins)
                    .font(.title)
                Text("mins")
                    .foregroundColor(.gray)
            }
            VStack(alignment: .center, spacing: 5) {
                Text(viewModel.leftSec)
                    .font(.title)
                Text("sec")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            viewModel.startCount()
        }
    }
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
    }
}
