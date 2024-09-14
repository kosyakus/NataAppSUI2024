//
//  AnimationViewContainer.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 14.09.2024.
//

import SwiftUI

struct AnimationViewContainer: View {
    
    @State var radius: CGFloat = 50
    
    var body: some View {
        VStack {
            AnimationScreen(radius: radius)
                .frame(height: 200)
            
            Slider(value: self.$radius, in: 42...100)
            
            Button(action: {
                withAnimation(.linear(duration: 1)) {
                    self.radius = 50
                }
            }) {
                Text("set radius")
            }
        }
    }
}
