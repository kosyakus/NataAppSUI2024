//
//  ProfileScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 05.09.2024.
//

import SwiftUI

struct ProfileScreen: View {
    @Binding var tabSelection: Int
    @Binding var selectedItem: Int?
    
    var body: some View {
        VStack {
            Text("This is the Profile Tab")
                .font(.title)
                .padding()
            
            Button("Go to Dashboard Tab and Select Item 2") {
                tabSelection = 1
                selectedItem = 1
            }
        }
    }
}

#Preview {
    ProfileScreen(tabSelection: .constant(0), selectedItem: .constant(nil))
}
