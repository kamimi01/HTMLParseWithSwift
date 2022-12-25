//
//  ContentView.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AdventarViewModel()

    var body: some View {
        VStack {
            Button(action: {
                viewModel.getArticles()
            }) {
                Text("パースする")
            }
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
        }
        .padding()
    }
}

private extension ContentView {

    var parsedText: String {
        if viewModel.errorMessage.isEmpty {
            return viewModel.text
        }
        return viewModel.errorMessage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
