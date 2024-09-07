//
//  DashboardScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 05.09.2024.
//

import SwiftUI

// MARK: - Model

struct Food {
    let name: String
    let isFavourite: Bool
}

/// Важно делать с помощью модулей!
extension Food: Identifiable{
    var id: String { name }
}

// MARK: - ViewModel

final class FoodModel: ObservableObject {
    
    @Published var isCatsFood: Bool = false
    @Published private(set) var foods = [
        Food(name: "🍎", isFavourite: true),
        Food(name: "🥖", isFavourite: false),
        Food(name: "🌽", isFavourite: true),
        Food(name: "🍕", isFavourite: false),
        Food(name: "🫐", isFavourite: true),
        Food(name: "🥦", isFavourite: false)
    ]
}

// MARK: - UI

struct DashboardScreen: View {
    
    @State var foodTitle: String = "My food"
    @StateObject var foodModel: FoodModel = .init()
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: FoodScreen(title: $foodTitle).environmentObject(foodModel)){
                Text("Food")
            }
        }
    }
}

struct FoodScreen: View {
    /// ни в Binding, ни в - не можем поставить значения
    @Binding var title: String
    @EnvironmentObject var foodModel: FoodModel
    
    var body: some View {
        VStack {
            Text(title).font(.largeTitle)
            List {
                ForEach(foodModel.foods) { item in
                    if !foodModel.isCatsFood || item.isFavourite {
                        NavigationLink(destination: Text(item.name).font(.system(size: 250))) {
                            Text(item.name)
                        }
                    }
                }
                Toggle(isOn: $foodModel.isCatsFood) {
                    Text("Toggle cat's food")
                }
                Button {
                    title = "Cat's food"
                } label: {
                    Text("Change the title")
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    DashboardScreen()
}
