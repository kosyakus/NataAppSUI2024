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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(FoodModel())
                .environmentObject(NewsVM())
        }.onChange(of: scenePhase, initial: true) { old, new in
            
            switch new {
            case .background: print("background")
            case .inactive: print("inactive")
            case .active: print("active")
            @unknown default: print("unknown")
            }
            
        }
    }
}
