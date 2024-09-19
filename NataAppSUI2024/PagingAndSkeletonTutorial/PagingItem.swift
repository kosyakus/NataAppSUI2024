//
//  PagingItem.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import SwiftUI

struct PagingItem: View {
    
    let name: String
    let gender: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
            Text(gender)
        }
    }
}
