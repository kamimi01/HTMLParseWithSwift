//
//  ContentView.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = AdventarViewModel()
    // こちらで初期化しないと検索を行うときにカウントされなくなってしまう
    @ObservedObject private var countDownViewModel = CountDownViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 255 / 255, green: 228 / 255, blue: 225 / 255)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 10) {
                    CountDownView(viewModel: countDownViewModel)
                        .padding(.top, 10)
                    Spacer()
                    switch viewModel.retreiveStatsu {
                    case .empty:
                        LottieView(animationType: .empty)
                            .frame(width: 300, height: 300)
                    case .loading:
                        LottieView(animationType: .loading)
                            .frame(width: 300, height: 300)
                    case .exist:
                        VStack {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(viewModel.articles) { article in
                                        ArticleCardView(article: article)
                                            .padding(.horizontal, 16)
                                    }
                                }
                            }
                        }
                    case .error:
                        VStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.orange)
                            Text("エラーが発生しました")
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle("Advent Counter")
        }
        .searchable(
            text: $viewModel.searchKeyword,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "7577"
        )
        .onSubmit(of: .search) {
            viewModel.getArticles()
        }
    }
}

private extension ContentView {
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
