//
//  AnimationScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 14.09.2024.
//

import SwiftUI

struct AnimationScreen: View {
    
    var radius: CGFloat
    
    var body: some View {
        /// ВАЖНО: порядок модификаторов имеет значение!
        /// например:
        VStack {
            Text("first text")
                .padding(.all, 20)
                .background(Color.gray)
                .border(.blue)
            Text("first text")
                .background(Color.gray)
                .padding(.all, 20)
                .border(.blue)
        }
        Text("modifier example")
            .modifier(CustomModifier())
        Circle()
            .fill(Color.gray)
            .frame(height: self.radius * 2)
//            .overlay(
//                Text("Animation")
//                    .font(.largeTitle)
//                    .foregroundColor(.blue))
    }
}
