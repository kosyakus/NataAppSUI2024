//
//  NewsDetailView.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 22.09.2024.
//

import SwiftUI
import NewsAPI

// Экран для отображения деталей статьи
struct NewsDetailView: View {
    var article: Article
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if let imageUrl = article.urlToImage {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    Text(article.title ?? "No title")
                        .font(.headline)
                        .padding([.leading, .trailing, .top])
                    
                    Text(article.description ?? "Нет описания")
                        .padding([.leading, .trailing])
                    
                    Text("Источник: \(article.source?.name ?? "Неизвестно")")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing, .bottom])
                    
                    Spacer() // Заполняет пространство и вытесняет кнопку вниз
                }
            }
            
            // Кнопка всегда внизу
            NavigationLink("Читать похожие", destination: ExtraInfoView(article: article))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .navigationTitle("Детали новости")
    }
}
