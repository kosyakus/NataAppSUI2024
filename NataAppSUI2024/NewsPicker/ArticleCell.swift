//
//  ArticleCell.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 22.09.2024.
//

import SwiftUI
import NewsAPI

struct ArticleCell: View {
    var article: Article
    
    var body: some View {
        HStack {
            if let imageUrl = article.urlToImage {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 60)
                        .clipped()
                }
            } else {
                // Заглушка, если изображения нет
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading) {
                Text(article.title ?? "")
                    .font(.headline)
                    .lineLimit(2)
                
                Text(article.source?.name ?? "Источник не указан")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}
