//
//  ModalScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 07.09.2024.
//

import SwiftUI

struct ModalScreen: View {
    
    @State private var isModalPresented: Bool = false
    
    var body: some View {
        VStack {
            Button("Open Modal Screen") {
                isModalPresented.toggle()
            }
            .padding()
            .sheet(isPresented: $isModalPresented) {
                ModalContentScreen()
            }
        }
    }
}

struct ModalContentScreen: View {
    var body: some View {
        VStack {
            Text("This is the Modal Screen!")
                .font(.title)
                .padding()
            Button("Dismiss") {
                // Действие для закрытия модального окна
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    windowScene.windows.first?.rootViewController?.dismiss(animated: true)
                }
            }
        }
    }
}

#Preview {
    ModalScreen()
}
