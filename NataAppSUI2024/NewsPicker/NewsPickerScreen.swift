//
//  NewsPickerScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 20.09.2024.
//

import SwiftUI
import NewsAPI

struct NewsPickerScreen: View {
//    @EnvironmentObject var newsVM: NewsViewModel
    @EnvironmentObject var newsViewModel: NewsPagingViewModel
    
    @State var selectedCategory = 0
    @State private var selectedArticle: Article? // Для хранения выбранной статьи
    @State private var isAnimating = false // Для контроля анимации
    
    var categories = ["Технологии", "Спорт", "Мир"]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Picker для выбора категории новостей
                Picker("", selection: $selectedCategory) {
                    ForEach(0 ..< categories.count, id: \.self) { i in
                        Text(categories[i]).tag(i)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selectedCategory) { newValue in
                        newsViewModel.resetData() // Сброс данных перед загрузкой новой категории
                        newsViewModel.loadNext(forCategory: newValue)
                    }
                
                List(newsViewModel.articles) { article in
                    // Переход на детальный экран статьи
                    NavigationLink(value: article) {
                        ArticleCell(article: article)
//                            .flyAwayAnimation(isAnimating: isAnimating, isSelected: selectedArticle == article) // Используем модификатор
//                            .onTapGesture {
//                                withAnimation {
//                                    selectedArticle = article
//                                    isAnimating = true
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//                                        isAnimating = false
//                                    }
//                                }
//                            }
                    }
                }
                .onAppear {
                    // Загрузка данных для первой категории при открытии
                    newsViewModel.loadNext(forCategory: selectedCategory)
                }
                .navigationDestination(for: Article.self) { article in
                    NewsDetailView(article: article)
                }
            }
        }
    }
}

//#Preview {
//    NewsPickerScreen()
//        .environmentObject(NewsViewModel())
//}

import SwiftUI

struct FlyAwayAnimationModifier: ViewModifier {
    var isAnimating: Bool
    var isSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .offset(isAnimating && isSelected ? CGSize(width: 100, height: 500) : .zero) // Двигаем ячейку
            .scaleEffect(isAnimating && isSelected ? 0.1 : 1) // Изменяем масштаб при анимации
            .animation(.easeInOut(duration: 0.6), value: isAnimating) // Применяем анимацию
    }
}

extension View {
    func flyAwayAnimation(isAnimating: Bool, isSelected: Bool) -> some View {
        self.modifier(FlyAwayAnimationModifier(isAnimating: isAnimating, isSelected: isSelected))
    }
}
