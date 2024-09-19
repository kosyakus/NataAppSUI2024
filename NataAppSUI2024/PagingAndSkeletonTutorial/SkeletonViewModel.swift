//
//  SkeletonViewModel.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import Foundation

class SkeletonViewModel: ObservableObject {
    @Published var loadedCharacters: [SkeletonItem] = []
    
    private var totalPages = -1
    private var totalCharacters = -1
    
    func initialLoad() {
        Task {
            guard let result = try? await CharactersAPI.getAllCharacters(page: 1) else { return }
            totalPages = result.info.pages
            totalCharacters = result.info.count
            
            // без асинк нельзя вносить изменения в loadedCharacters, т к он влияет на UI
            DispatchQueue.main.async {
                self.loadedCharacters = Array(repeating: SkeletonItem(), count: self.totalCharacters)
            }
            
            /// для запуска в background - concurrent loading (конкурентную загрузку страничек, НЕ последовательную)
            await withTaskGroup(of: Void.self) { group in
                for pageNum in 1...totalPages {
                    group.addTask {
                        guard let result = try? await CharactersAPI.getAllCharacters(page: pageNum) else { return }
                        
                        for currentCharacter in result.results ?? [] {
                            DispatchQueue.main.async {
                                self.loadedCharacters[currentCharacter.id - 1].character = currentCharacter
                            }
                        }
                    }
                }
            }
            
        }
    }
    
}
