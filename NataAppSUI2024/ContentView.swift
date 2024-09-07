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
            /// Для таб вью - любая вью это экран. Хоть просто Text
        }
    }
}

#Preview {
    ContentView()
}
