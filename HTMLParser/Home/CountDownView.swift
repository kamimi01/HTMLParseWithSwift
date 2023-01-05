//
//  CountDownView.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2023/01/06.
//

import SwiftUI

struct CountDownView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            VStack(alignment: .center, spacing: 5) {
                Text("24")
                    .font(.title)
                Text("days")
                    .foregroundColor(.gray)
            }
            VStack(alignment: .center, spacing: 5) {
                Text("11")
                    .font(.title)
                Text("hours")
                    .foregroundColor(.gray)
            }
            VStack(alignment: .center, spacing: 5) {
                Text("30")
                    .font(.title)
                Text("mins")
                    .foregroundColor(.gray)
            }
            VStack(alignment: .center, spacing: 5) {
                Text("22")
                    .font(.title)
                Text("sec")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
    }
}
