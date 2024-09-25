//
//  CharactersView.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 25.09.2024.
//

import SwiftUI

struct CharactersView: View {
    @StateObject private var viewModel = PagingViewModel()

        var body: some View {
            List(viewModel.loadedCharacters, id: \.id) { character in
                Text(character.name)
            }
            .onAppear {
                viewModel.loadNext()
            }
        }
}


//#Preview {
//    CharactersView()
//}
