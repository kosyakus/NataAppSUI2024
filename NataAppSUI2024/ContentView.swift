//
//  ContentView.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 05.09.2024.
//

import SwiftUI

/// Можно отрефакторить
enum ScreenTab {
    case dashboard, profile, news, navigation, full, animation
}

@available(iOS 16.0, *)
struct ContentView: View {
    
    @State var tabSelected: ScreenTab = .animation
    
    @State var selectedItem: Int? = nil  // Для выбора пункта таблицы
    @State private var sliderValue: Float = 50.0
    
    var body: some View {
        TabView(selection: $tabSelected) {
//            ProfileScreen(tabSelection: $tabSelected, selectedItem: $selectedItem)
//                .tag(ScreenTab.profile)
//                .tabItem {
//                    Label("Profile", systemImage: "person")
//                }
            DashboardScreen(selectedItem: $selectedItem)
                .tag(ScreenTab.dashboard)
                .tabItem {
                    Label("Dashboard", systemImage: "star")
                }
            AnimationViewContainer(radius: 50)
                .tag(ScreenTab.animation)
                .tabItem {
                    Label("Animation", systemImage: "wand.and.rays")
                }
//            NewsScreen()
//                .tag(ScreenTab.news)
//                .tabItem {
//                    Label("News", systemImage: "newspaper")
//                }
//            
//            FullScreenCoverScreen()
//                .tag(ScreenTab.full)
//                .tabItem {
//                    Label("Navi", systemImage: "location")
//                }
            
            /// как вариант создания таба
            //                    HStack {
            //                        Text("Dashboard")
            //                        Image(systemName: "star")
            //                    }
            
            //            ModalScreen()
            //                .tag(2)
            //                .tabItem {
            //                    Label("Modal", systemImage: "cat")
            //                }
            //            SliderScreen(value: $sliderValue)
            //                .frame(width: 300)
            //                .tag(3)
            //                .tabItem {
            //                    Label("Slider", systemImage: "slider.horizontal.3")
            //                }
            /// Для таб вью - любая вью это экран. Хоть просто Text
        }
    }
}

@available(iOS 16.0, *)
extension ContentView {
    
    /// суть функции - получить извещение о том, что таб поменялся
    private func tabSelection() -> Binding<ScreenTab> {
        Binding {
            self.tabSelected
        } set: { tappedTab in
            print("tab clicked")
            self.tabSelected = tappedTab
        }
    }
}

@available(iOS 16.0, *)
#Preview {
    ContentView()
}
