//
//  SkeletonView.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import SwiftUI


/// нужно заранее знать количество элементов для отображения
struct SkeletonView: View {
    
    @StateObject var viewModel = SkeletonViewModel()
    
    var body: some View {
        List(viewModel.loadedCharacters, id: \.self) { item in
            CharacterItem(data: item)
        }
        .onAppear {
            viewModel.initialLoad()
        }
    }
}

#Preview {
    SkeletonView()
}
