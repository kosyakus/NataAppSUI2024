//
//  CharactersViewModel.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 25.09.2024.
//

import Foundation

class CharactersViewModel: ObservableObject {
    
    @Published var loadedCharacters: [ModelCharacter] = []
        @Published var canLoad = true
        
        @Injected private var charactersAPI: CharactersAPIProtocol

        private var page = 1
        private var totalPages = 1000
        
        func loadNext() {
            guard page <= totalPages else { return }
            guard canLoad else { return }
            
            canLoad = false
            Task { @MainActor in
                sleep(3) // Для проверки

                // Используем API для получения данных
                do {
                    let newCharacters = try await charactersAPI.getAllCharacters(page: page)
                    loadedCharacters.append(contentsOf: newCharacters)
                    page += 1
                } catch {
                    print("Error loading characters: \(error)")
                }
                canLoad = true
            }
        }
}
