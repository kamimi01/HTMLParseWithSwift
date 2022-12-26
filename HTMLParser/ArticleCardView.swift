//
//  ArticleCardView.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/26.
//

import SwiftUI

struct ArticleCardView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 15) {
                iconImage
                Text(article.title)
                    .lineLimit(2)
                    .font(.headline)
            }
            HStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Created at:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(article.date)
                }
                VStack(alignment: .leading) {
                    Text("Written by:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(article.name)
                }
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.pink)
        .cornerRadius(15)
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
                ProgressView()
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
