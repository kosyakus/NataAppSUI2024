//
//  ExtraInfoView.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 22.09.2024.
//

import SwiftUI
import NewsAPI

// Экран с дополнительной информацией (третий экран)
struct ExtraInfoView: View {
    var article: Article
    @EnvironmentObject var newsVM: NewsPagingViewModel // Подключаем ViewModel для получения связанных статей
    
    var body: some View {
        VStack {
            Text("Дополнительная информация")
                .font(.headline)
                .padding()
            
            // Текущая статья
            Text("Читаемая статья: \(article.title ?? "No title")")
                .font(.subheadline)
                .padding()
            
            // Если есть похожая статья, отображаем ее
            if let relatedArticle = newsVM.relatedArticles.first {
                Text("Похожая статья: \(relatedArticle.title ?? "No related articles")")
                    .font(.subheadline)
                    .padding()
                
                Text(relatedArticle.description ?? "Нет описания для похожей статьи")
                    .padding()
                
            } else {
                Text("Загружаем похожие статьи...")
            }
        }
        .onAppear {
            // Загружаем похожие статьи при открытии экрана
            newsVM.fetchRelatedArticles(for: article.title ?? "")
        }
        .navigationTitle("Доп. информация")
    }
}
