//
//  CharactersViewModel.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 25.09.2024.
//

import Combine
import Foundation
import StorageServicePackage

class CharactersViewModel: ObservableObject {
    
    @Published var loadedCharacters: [ModelCharacter] = []
    @Published var canLoad = true
    
    @Injected private var charactersAPI: CharactersAPIProtocol
    @Injected private var storageService: StorageServiceProtocol
    
    private var page = 1
    private var totalPages = 1000
    
    private var cancellables = Set<AnyCancellable>() // Храним подписки Combine
    
    init() {
        // Загружаем сохраненные данные из локального хранилища
        if let savedCharacters: [ModelCharacter] = try? storageService.load(forKey: "charactersCache", as: [ModelCharacter].self) {
            loadedCharacters = Array(Set(savedCharacters)) // Убираем дубликаты
        }
    }
    
    func loadNext() {
        guard page <= totalPages else { return }
        guard canLoad else { return }
        
        canLoad = false
        
        // Запускаем Combine-поток для загрузки данных
        charactersAPI.getAllCharacters(page: page)
            .receive(on: DispatchQueue.main) // Работаем с результатом на главном потоке
            .sink(receiveCompletion: { [weak self] completion in
                // Обрабатываем ошибки, если есть
                if case .failure(let error) = completion {
                    print("Error loading characters: \(error)")
                    self?.canLoad = true
                }
            }, receiveValue: { [weak self] newCharacters in
                guard let self = self else { return }
                
                // Фильтруем новые данные, чтобы не добавить дубликаты
                let uniqueNewCharacters = newCharacters.filter { newCharacter in
                    !self.loadedCharacters.contains(where: { $0.id == newCharacter.id })
                }
                
                // Добавляем только уникальные персонажи
                self.loadedCharacters.append(contentsOf: uniqueNewCharacters)
                
                // Сохраняем данные в кэш, удаляя дубликаты
                let uniqueLoadedCharacters = Array(Set(self.loadedCharacters))
                try? self.storageService.save(uniqueLoadedCharacters, forKey: "charactersCache")
                
                // Переходим к следующей странице
                self.page += 1
                self.canLoad = true
            })
            .store(in: &cancellables) // Сохраняем подписку
    }
}
