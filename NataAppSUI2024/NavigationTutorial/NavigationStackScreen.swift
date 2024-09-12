//
//  NavigationStackScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 12.09.2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct NavigationStackScreen: View {
    
    /// это наш стек и каждое значение будет отображать экран
    ///  лучше айди сущностей или энамы
    @State var path: [Int] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            Text("Navi stack tutorial")
            VStack {
                NavigationLink(value: 1) {
                    Text("Navi stack tutorial - first child screen")
                }
                NavigationLink(value: 2) {
                    Text("Navi stack tutorial - second child screen")
                }
            }
            .navigationDestination(for: Int.self) { value in
                switch value {
                case 1:
                    FirstChildView()
                case 2:
                    SecondChildView()
                case 3:
                    ThirdChildView()
                default:
                    FirstChildView()
                }
            }
        }
    }
}

@available(iOS 16.0, *)
#Preview {
    NavigationStackScreen()
}
