//
//  NewsPagingViewModel.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 21.09.2024.
//

import Foundation
import NewsAPI

class NewsPagingViewModel: ObservableObject {
    
    @Published var articles: [Article] = .init()
    @Published var relatedArticles: [Article] = .init()
    @Published var canLoad = true
    
    let categories = ["technology", "sports", "world"]
    
    private var page = 1
    private var totalPages = 1000
    
    // Сброс данных при смене категории
        func resetData() {
            self.articles = []
            self.page = 1
            self.totalPages = 1000
        }
    
    func loadNext(forCategory: Int) {
        guard page <= totalPages else { return }
        guard canLoad else { return }
        
        let selectedCategory = categories[forCategory]
        
        canLoad = false
        Task { @MainActor in // Задача будет выполняться в основном потоке
            
            // для проверки
            //             sleep(3)
            ArticlesAPI.everythingGet(q: selectedCategory,
                                      from: "2024-09-01",
                                      sortBy: "publishedAt",
                                      language: "en",
                                      apiKey: "8e7caac0fb8c4c2ba9f3324db7ed392d") { result, error in
                
                // Если есть ошибка, возвращаем canLoad в true и завершаем выполнение
                if let error = error {
                    print("Ошибка: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.canLoad = true
                    }
                    return
                }
                
                guard let result = result else {
                    DispatchQueue.main.async {
                        self.canLoad = true
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    // Обрабатываем totalResults
                    self.totalPages = (result.totalResults / 20) + 1 // Предполагаем, что на каждой странице 20 статей
                    
                    // Добавляем загруженные статьи в массив
                    self.articles.append(contentsOf: result.articles ?? [])
                    self.page += 1
                    self.canLoad = true
                }
            }
        }
        
    }
    
    // Метод для получения похожих статей на основе ключевого слова
    func fetchRelatedArticles(for title: String) {
        // Разделяем заголовок на слова
        let words = title.split(separator: " ")
        
        // Выбираем самое длинное слово
        if let keyword = words.max(by: { $1.count > $0.count }) {
            let keywordString = String(keyword) // Преобразуем Substring в String
            
            ArticlesAPI.everythingGet(q: keywordString,
                                      from: "2024-09-01",
                                      sortBy: "publishedAt",
                                      language: "en",
                                      apiKey: "8e7caac0fb8c4c2ba9f3324db7ed392d") { data, error in
                DispatchQueue.main.async {
                    self.relatedArticles = data?.articles ?? []
                }
            }
        }
    }
}
