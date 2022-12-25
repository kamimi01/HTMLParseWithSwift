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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(parsedText)
            Button(action: {
                viewModel.getArticles()
            }) {
                Text("パースする")
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
