//
//  EmptyFileView.swift
//  To-Do
//
//  Created by Ritika Meena on 02/06/24.
//

import Lottie
import SwiftUI

struct EmptyFileView: UIViewRepresentable {
    
    var animationFileName: String
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

                let animationView = LottieAnimationView(name: animationFileName)
                animationView.contentMode = .scaleAspectFit
                animationView.loopMode = .loop
                animationView.play()

                view.addSubview(animationView)

                animationView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
                    animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
                ])

                return view
        
//        let animationView = LottieAnimationView(name: animationFileName)
//        animationView.loopMode = loopMode
//        animationView.play()
//        animationView.contentMode = .scaleAspectFill
//        return animationView
    }
}
