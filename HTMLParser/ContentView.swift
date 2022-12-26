//
//  ContentView.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AdventarViewModel()
    @State private var isShownSetting = false

    var body: some View {
        VStack {
            settingButton
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.articles) { article in
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text(article.date)
                                Text(article.name)
                                AsyncImage(
                                    url: URL(string: article.iconImage)!,
                                    content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 50, maxHeight: 50)
                                    },
                                    placeholder: {
                                        ProgressView()
                                    }
                                )
                            }
                            .frame(width: 70)
                            VStack(alignment: .leading) {
                                Text(article.title)
                                Text(article.url)
                                    .font(.caption)
                            }
                        }
                        Divider()
                            .background(Color.red)
                    }
                }
            }
//            .navigationTitle("カレンダー一覧")
//            .navigationBarItems(leading: nil, trailing: settingButton)
//            .navigationTitle("【ふりかえり】iOSグループでデイリーミーティングと雑談会をはじめました！")
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(
//                leading: nil,
//                trailing: settingButton
//            )
        }
        .padding()
        .sheet(isPresented: $isShownSetting) {
            SettingScreen(searchKeyword: $viewModel.searchKeyword, viewModel: viewModel)
        }
    }
}

private extension ContentView {
    var settingButton: some View {
        Button(action: {
            print("右のボタンが押されたよ")
            isShownSetting = true
        }){
            Image(systemName: "gearshape")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
