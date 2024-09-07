//
//  ContentView.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 05.09.2024.
//

import SwiftUI

/// Можно отрефакторить
enum ScreenTab {
    case dashboard, profile
}

struct ContentView: View {
    
    @State var tabSelection: Int = 0
    @State var selectedItem: Int? = nil  // Для выбора пункта таблицы
    @State private var sliderValue: Float = 50.0

    var body: some View {
        TabView(selection: $tabSelection) {
            ProfileScreen(tabSelection: $tabSelection, selectedItem: $selectedItem)
                .tag(2)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            DashboardScreen(selectedItem: $selectedItem)
                .tag(1)
                .tabItem {
                    Label("Dashboard", systemImage: "star")
                    /// как вариант создания таба
//                    HStack {
//                        Text("Dashboard")
//                        Image(systemName: "star")
//                    }
                }
            ModalScreen()
                .tag(2)
                .tabItem {
                    Label("Modal", systemImage: "cat")
                }
            SliderScreen(value: $sliderValue)
                .frame(width: 300)
                .tag(2)
                .tabItem {
                    Label("Slider", systemImage: "slider.horizontal.3")
                }
            /// Для таб вью - любая вью это экран. Хоть просто Text
        }
    }
}

#Preview {
    ContentView()
}
