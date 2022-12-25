//
//  ContentView.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var parser = AdventarViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(parsedText)
            Button(action: {
                parse()
            }) {
                Text("パースする")
            }
        }
        .padding()
    }
}

private extension ContentView {
    func parse() {
        parser.parser()
    }

    var parsedText: String {
        if parser.errorMessage.isEmpty {
            return parser.text
        }
        return parser.errorMessage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
