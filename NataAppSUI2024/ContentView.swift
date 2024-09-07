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
    var body: some View {
        TabView(selection: $tabSelection) {
            DashboardScreen()
                .tag(0)
                .tabItem {
                    Label("Dashboard", systemImage: "star")
                    /// как вариант создания таба
//                    HStack {
//                        Text("Dashboard")
//                        Image(systemName: "star")
//                    }
                }
            ProfileScreen()
                .tag(1)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            /// Для таб вью - любая вью это экран. Хоть просто Text
        }
    }
}

#Preview {
    ContentView()
}
