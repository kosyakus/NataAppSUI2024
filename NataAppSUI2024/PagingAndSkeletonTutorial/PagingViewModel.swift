//
//  PagingViewModel.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import Foundation

class PagingViewModel: ObservableObject {
    
    @Published var loadedCharacters: [ModelCharacter] = []
    @Published var canLoad = true
    
    private var page = 1
    private var totalPages = 1000
    
    func loadNext() {
        guard page <= totalPages else { return }
        guard canLoad else { return }
        
        canLoad = false
        Task { @MainActor in // Задача будет выполняться в основном потоке
            
            // для проверки
             sleep(3)
            guard let result = try? await CharactersAPI.getAllCharacters(page: page) else {
                canLoad = true
                return
            }
            
            totalPages = result.info.pages
            loadedCharacters.append(contentsOf: result.results ?? [])
            page += 1
            canLoad = true
        }
    }
    
}
