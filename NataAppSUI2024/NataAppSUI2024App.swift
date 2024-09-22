//
//  NataAppSUI2024App.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 05.09.2024.
//

import SwiftUI

@available(iOS 17.0, *)
@main
struct NataAppSUI2024App: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var newsVM = NewsPagingViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(FoodModel())
                .environmentObject(newsVM)
        }.onChange(of: scenePhase, initial: true) { old, new in
            
            switch new {
            case .background: print("background")
            case .inactive: print("inactive")
            case .active: print("active")
            @unknown default: print("unknown")
            }
            
        }
    }
    
    /// Чтобы открыть приложение с помощью Deep Link
    /// В браузере ввести: deepLinkName://
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .onOpenURL(perform: { url in
//                    print("DeepLink: \(url)")
//                })
//        }
//    }
    
    
    
    /// Можно прям здесь создать NavigationControllerView чтобы навигация была с самого начала приложение
//    var body: some Scene {
//        WindowGroup {
//            NavigationControllerView(transition: .custom(.slide, .opacity)) {
//                ContentView()
//            }
//        }
//    }
}
