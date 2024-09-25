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
        
        private var page = 1
        private var totalPages = 1000
        
        private let charactersAPI: CharactersAPIProtocol?

        init() {
            // Получаем API сервис через Service Locator
            self.charactersAPI = ServiceLocator.shared.getService()
        }
        
        func loadNext() {
            guard page <= totalPages else { return }
            guard canLoad else { return }
            
            canLoad = false
            Task { @MainActor in
                sleep(3) // Для проверки

                guard let charactersAPI = charactersAPI else {
                    canLoad = true
                    print("No API service available")
                    return
                }

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
