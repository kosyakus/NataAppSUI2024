//
//  NewsScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 09.09.2024.
//

import SwiftUI
import NewsAPI

extension Article: Identifiable {
    public var id: String { url }
}

struct NewsScreen: View {
    
    @EnvironmentObject var newsVM: NewsVM
    
    /// через State объявляем UI параметры обычно
    @State var viewVariant = 0
    var variants = ["List", "Grid", "Grid iOS13"]
    
    var body: some View {
//        Text("Good news, everyone!")
        VStack {
            Picker("",selection: $viewVariant) {
                ForEach(0 ..< variants.count, id:  \.self) { i in
                    Text(variants[i]).tag(i)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            switch viewVariant {
            case 0: list
            case 1: grid
            case 2: gridios13
            default: EmptyView()
            }
        }
        list
    }
    
    var list: some View {
        List(newsVM.articles) { art in
            ListArticleCell(article: art)
        }
    }
    
    var gridios13: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(0 ..< newsVM.articles2D.count, id:  \.self) { row in
                    HStack(spacing: 8) {
                        ForEach(newsVM.articles2D[row]) { art in
                            ListArticleCell(article: art)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    var grid: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                ForEach(newsVM.articles) { art in
                    ListArticleCell(article: art)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct ListArticleCell: View {
    
    var article: Article?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.gray)
            VStack {
                Text(article?.title ?? article?.description ?? "")
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
    }
}

//#Preview {
//    NewsScreen()
//}
