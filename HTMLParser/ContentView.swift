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
        NavigationView {
            ZStack {
                Color(red: 255 / 255, green: 228 / 255, blue: 225 / 255)
                    .edgesIgnoringSafeArea(.all)
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
