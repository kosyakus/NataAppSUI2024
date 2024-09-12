//
//  SecondChildView.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 12.09.2024.
//

import SwiftUI

struct SecondChildView: View {
    var body: some View {
        NavigationLink(value: 3) {
            Text("SecondChildView")
        }
    }
}

#Preview {
    SecondChildView()
}
