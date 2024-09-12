//
//  FullScreenCoverScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 12.09.2024.
//

import SwiftUI

struct FullScreenCoverScreen: View {
    
    @State var isShown = false
    
    var body: some View {
        VStack {
            Text("FullScreenCoverScreen")
                .fullScreenCover(isPresented: $isShown, content: {
                    FullScreenChildView()
                })
            Button(action: {
                isShown.toggle()
            }, label: {
                Text("toggle button")
            })
        }
        
    }
}

#Preview {
    FullScreenCoverScreen()
}
