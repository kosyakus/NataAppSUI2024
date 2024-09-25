//
//  CharactersViewModel.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 25.09.2024.
//

import Foundation

import StorageServicePackage

class CharactersViewModel: ObservableObject {
    
    @Published var loadedCharacters: [ModelCharacter] = []
    @Published var canLoad = true
    
    @Injected private var charactersAPI: CharactersAPIProtocol
    @Injected private var storageService: StorageServiceProtocol
    
    private var page = 1
    private var totalPages = 1000
    
    init() {
        // Загружаем сохраненные данные из локального хранилища
        if let savedCharacters: [ModelCharacter] = try? storageService.load(forKey: "charactersCache", as: [ModelCharacter].self) {
            // Удаляем дубликаты перед загрузкой
            loadedCharacters = Array(Set(savedCharacters))
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
                
                // Фильтруем новые данные, чтобы не добавить дубликаты
                let uniqueNewCharacters = newCharacters.filter { newCharacter in
                    !loadedCharacters.contains(where: { $0.id == newCharacter.id })
                }
                
                // Добавляем только уникальные персонажи
                loadedCharacters.append(contentsOf: uniqueNewCharacters)
                
                // Сохраняем данные в кэш, удаляя дубликаты
                let uniqueLoadedCharacters = Array(Set(loadedCharacters))
                try storageService.save(uniqueLoadedCharacters, forKey: "charactersCache")
                
                // Переходим к следующей странице
                page += 1
            } catch {
                print("Error loading characters: \(error)")
            }
            canLoad = true
        }
    }
}
