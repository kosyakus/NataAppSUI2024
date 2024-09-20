//
//  NewsPickerScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 20.09.2024.
//

import SwiftUI
import NewsAPI

struct NewsPickerScreen: View {
    @EnvironmentObject var newsVM: NewsViewModel
    
    @State var selectedCategory = 0
    
    var categories = ["Технологии", "Спорт", "Мир"]
    
    var body: some View {
        VStack {
            // Picker для выбора категории новостей
            Picker("", selection: $selectedCategory) {
                ForEach(0 ..< categories.count, id: \.self) { i in
                    Text(categories[i]).tag(i)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedCategory, perform: { newValue in
                    // Вызываем метод загрузки данных при изменении категории
                    newsVM.fetchArticles(for: newValue)
                })
            
            List(newsVM.articles) { article in
                ArticleCell(article: article, selectedCategory: selectedCategory)
            }
            .onAppear {
                // Загрузка данных для первой категории при открытии
                newsVM.fetchArticles(for: selectedCategory)
            }
        }
    }
}

//#Preview {
//    NewsPickerScreen()
//        .environmentObject(NewsViewModel())
//}

struct NewsListView: View {
    
    @EnvironmentObject var newsVM: NewsViewModel
    var categoryIndex: Int
    
    var body: some View {
        List(newsVM.articles) { article in
            ListArticleCell(article: article)
        }
        .onAppear {
            newsVM.fetchArticles(for: categoryIndex)
        }
    }
}

struct ArticleCell: View {
    
    var article: Article?
    var selectedCategory: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(backgroundColor)
            VStack {
                Text(article?.title ?? article?.description ?? "")
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
    }
    
    var backgroundColor: Color {
        switch selectedCategory {
        case 0:
            return .mint
        case 1:
            return .blue
        case 2:
            return .orange
        default:
            return .gray
        }
    }
}

final class NewsViewModel: ObservableObject {
    
    @Published var articles: [Article] = .init()
    
    let categories = ["technology", "sports", "world"]
    
    // Метод для получения новостей в зависимости от выбранной категории
    func fetchArticles(for categoryIndex: Int) {
        let selectedCategory = categories[categoryIndex]
        
        ArticlesAPI.everythingGet(q: selectedCategory,
                                  from: "2024-09-01",
                                  sortBy: "publishedAt",
                                  language: "en",
                                  apiKey: "8e7caac0fb8c4c2ba9f3324db7ed392d") { data, error in
            DispatchQueue.main.async {
                self.articles = data?.articles ?? []
            }
        }
    }
}
