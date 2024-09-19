//
//  CharacterItem.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import SwiftUI

struct CharacterItem: View {
    
    let data: SkeletonItem
    
    var body: some View {
        if data.character == nil {
            // имитируем скелетон вью
            VStack {
                SkeletonLoadingView(shape: Rectangle(),
                                    animation: .easeIn(duration: 3).repeatForever(autoreverses: true),
                                    gradient: Gradient(colors: [.black, .white, .black]))
                .frame(height: 70)
                .cornerRadius(35)
                SkeletonLoadingView(shape: Rectangle(),
                                    animation: .easeIn(duration: 3).repeatForever(autoreverses: true),
                                    gradient: Gradient(colors: [.black, .white, .black]))
                .frame(height: 70)
                .cornerRadius(35)
            }
        } else {
            VStack(alignment: .leading) {
                Text("Name: \(data.character?.name ?? "")")
                Text("Gender: \(data.character?.gender ?? "")")
            }
        }
    }
}

#Preview {
    CharacterItem(data: SkeletonItem())
}
