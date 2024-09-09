//
//  NewsVM.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 09.09.2024.
//

import Foundation
import SwiftUI
import NewsAPI

final class NewsVM: ObservableObject {
    
    @Published var articles: [Article] = .init()
    @Published var articles2D: [[Article]] = .init()
    
    init() {
        
        ArticlesAPI.everythingGet(q: "iPhone 16",
                                  from: "2024-09-01",
                                  sortBy: "publishedAt",
                                  language: "en",
                                  apiKey: "8e7caac0fb8c4c2ba9f3324db7ed392d") { data, error in
            self.articles = data?.articles ?? []
            self.collect2D()
        }
    }
    
    func collect2D() {
        let columned = articles.publisher.collect(3)
        _ = columned.collect().sink { self.articles2D = $0 }
    }
    
}
