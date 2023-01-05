//
//  AnimationView.swift
//  HTMLParser
//
//  Created by mikaurakawa on 2022/12/26.
//

import SwiftUI
import Lottie

enum AnimationType: String {
    case empty = "empty-state"
    case loading = "loading"
}

struct LottieView: UIViewRepresentable {
    let animationType: AnimationType

    func makeUIView(context: Context) -> UIView {
        let view = LottieAnimationView(name: animationType.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false

        let parentView = UIView()
        parentView.addSubview(view)
        parentView.addConstraints([
            view.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            view.heightAnchor.constraint(equalTo: parentView.heightAnchor)
        ])

        view.play()
        view.loopMode = .loop

        return parentView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
