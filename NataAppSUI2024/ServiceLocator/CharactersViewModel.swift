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
    @Injected private var storageService: StorageServiceProtocol
    
    private var page = 1
    private var totalPages = 1000
    
    init() {
        // При инициализации пытаемся загрузить сохраненные данные
        if let savedCharacters: [ModelCharacter] = try? storageService.load(forKey: "charactersCache", as: [ModelCharacter].self) {
            loadedCharacters = savedCharacters
        }
    }
    
    func loadNext() {
        guard page <= totalPages else { return }
        guard canLoad else { return }
        
        canLoad = false
        Task { @MainActor in
            sleep(3) // Для проверки
            
            do {
                let newCharacters = try await charactersAPI.getAllCharacters(page: page)
                loadedCharacters.append(contentsOf: newCharacters)
                
                // Сохраняем данные в локальное хранилище
                try storageService.save(loadedCharacters, forKey: "charactersCache")
                // Переходим к следующей странице
                page += 1
            } catch {
                print("Error loading characters: \(error)")
            }
            canLoad = true
        }
    }
}
