//
//  NewsPickerScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 20.09.2024.
//

import SwiftUI
import NewsAPI

struct NewsPickerScreen: View {
    
    @EnvironmentObject var newsViewModel: NewsPagingViewModel
    
    @State var selectedCategory = 0
    @State private var selectedArticle: Article?
    
    // For animation
    @State private var animateScreen = false
    @State private var screenPosition = CGSize.zero
    @State private var screenScale: CGFloat = 1.0
    @State private var showFlyingScreen = false
    @State private var snapshotImage: UIImage? // Здесь будет храниться снимок
    
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
                        if !animateScreen {
                            // Создаем скриншот и запускаем анимацию
                            takeScreenSnapshot()
                        }
                        newsViewModel.resetData() // Сброс данных перед загрузкой новой категории
                        newsViewModel.loadNext(forCategory: newValue)
                    }
                
                
                List(newsViewModel.articles) { article in
                    // Переход на детальный экран статьи
                    NavigationLink(value: article) {
                        ArticleCell(article: article)
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
            
            // Анимированный "улетающий" скриншот
            if let snapshotImage = snapshotImage, showFlyingScreen {
                Image(uiImage: snapshotImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .scaleEffect(screenScale)
                    .offset(screenPosition)
                    .onAppear {
                        startScreenAnimation()
                    }
            }
        }
    }
    
    // Функция для захвата скриншота пикера
    func takeScreenSnapshot() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        // Создаем снимок всего экрана
        let pickerSnapshot = window.asImage()
        
        // Устанавливаем снимок
        snapshotImage = pickerSnapshot
        screenPosition = CGSize(width: 0, height: -UIScreen.main.bounds.height / 2) // Начало в верхней части экрана
        
        // Запускаем анимацию
        showFlyingScreen = true
    }
    
    // Анимация "улета" снимка
    func startScreenAnimation() {
        // Анимация полета снимка пикера
        withAnimation(.easeInOut(duration: 1.0)) {
            screenPosition = CGSize(width: 0, height: UIScreen.main.bounds.height) // Улетает за границу экрана
            screenScale = 0.2 // Уменьшается до 20%
        }
        
        // После завершения анимации скрываем снимок
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showFlyingScreen = false
            screenPosition = .zero
            screenScale = 1.0
            snapshotImage = nil // Удаляем снимок
        }
    }
    
}

//#Preview {
//    NewsPickerScreen()
//        .environmentObject(NewsViewModel())
//}
