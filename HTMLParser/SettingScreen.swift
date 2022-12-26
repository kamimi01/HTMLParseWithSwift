//
//  SettingScreen.swift
//  AdventarCounter
//
//  Created by mikaurakawa on 2022/12/15.
//

import SwiftUI

struct SettingScreen: View {
    @Binding var searchKeyword: String
    @State var viewModel: AdventarViewModel

    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("アドベントカレンダーのキーワード")
                TextField("7577", text: $searchKeyword)
                    .border(Color.gray)
            }

            Button(action: {
                viewModel.getArticles()
            }) {
                Text("記事を取得")
            }
//            Button(action: {
//                endLiveActivity()
//            }) {
//                Text("Live Activityを終了する")
//            }
        }
        .padding(.horizontal, 50)
    }
}

private extension SettingScreen {
//    func endLiveActivity() {
//        for activity in LiveActivityService.activities {
//            LiveActivityService.endActivity(activity)
//        }
//    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen(searchKeyword: .constant("7577"), viewModel: AdventarViewModel())
    }
}
