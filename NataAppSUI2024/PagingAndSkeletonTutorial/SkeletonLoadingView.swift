//
//  SkeletonLoadingView.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import SwiftUI

struct SkeletonLoadingView<ShapeType: Shape>: View {
    
    @State private var animationPosition: CGFloat = -1
    
    let shape: ShapeType
    let animation: Animation
    let gradient: Gradient
    
    var body: some View {
        shape
            .fill(self.gradientFill())
            .onAppear {
                withAnimation(animation) {
                    animationPosition = 2
                }
            }
    }
    
    private func gradientFill() -> LinearGradient {
        return LinearGradient(gradient: gradient,
                              startPoint: .init(x: animationPosition - 1, y: animationPosition - 1),
                              endPoint: .init(x: animationPosition + 1, y: animationPosition + 1))
    }
}

#Preview {
    SkeletonLoadingView(shape: Rectangle(), animation: .easeIn(duration: 3).repeatForever(), gradient: Gradient(colors: [.black, .white, .black]))
}
