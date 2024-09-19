//
//  PagingView.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import SwiftUI

struct PagingView: View {
    
    @StateObject var viewModel = PagingViewModel()
    
    var body: some View {
        List(viewModel.loadedCharacters, id: \.self) { item in
            
            // если долгая подгрузка, до добавляем проверку
            let isElementLast = viewModel.loadedCharacters.needToLoad(item)
            let isLoadingInProgress = isElementLast && viewModel.canLoad == false
            
            PagingItem(name: item.name, gender: item.gender)
                .modifier(LoadingModifier(withLoading: isLoadingInProgress))
//                .progressBar(isLoading: isLoadingInProgress)
                .onAppear {
                    // проверяем элемент таблицы и подгружаем постепенно
                    if isElementLast {
                        viewModel.loadNext()
                    }
                }
            
//            if isLoadingInProgress {
//                ProgressView().progressViewStyle(.circular)
//            } else {
//                
//                PagingItem(name: item.name, gender: item.gender)
//                    .onAppear {
//                        // проверяем элемент таблицы и подгружаем постепенно
//                        if isElementLast {
//                            viewModel.loadNext()
//                        }
//                    }
//            }
        }
        .onAppear {
            viewModel.loadNext()
        }
    }
}

#Preview {
    PagingView()
}


/// Как вариант - написать здесь Extension
private extension View {
    func progressBar(isLoading: Bool) -> some View {
        self
            .modifier(LoadingModifier(withLoading: isLoading))
    }
}
