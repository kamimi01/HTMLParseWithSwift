//
//  ArticleCardView.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/26.
//

import SwiftUI

struct ArticleCardView: View {
    let article: Article
    @Environment(\.openURL) var openURL

    var body: some View {
        Button(action: {
            openURL(URL(string: article.url)!)
        }) {
            HStack {
                VStack(alignment: .center, spacing: 10) {
                    iconImage
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Created at:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(article.date)
                            .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.title)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                        .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Written by:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(article.name)
                            .lineLimit(1)
                            .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                    }
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

private extension ArticleCardView {
    var iconImage: some View {
        AsyncImage(
            url: URL(string: article.iconImage)!,
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(maxWidth: 40, maxHeight: 40)
            },
            placeholder: {
                Image(systemName: "person.fill")
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: 40, maxHeight: 40)
            }
        )
    }
}

struct ArticleCardView_Previews: PreviewProvider {
    static let article = Article(
        date: "12/1",
        name: "kamimi",
        url: "https://qiita.com/kamimi01/items/c220cccd35ad00157a9a",
        title: "【SwiftSoup】ADVENTARから取得したHTMLをパースしてアプリに表示する",
        iconImage: "https://avatars1.githubusercontent.com/u/47489629?v=4"
    )

    static var previews: some View {
        ArticleCardView(article: article)
    }
}
