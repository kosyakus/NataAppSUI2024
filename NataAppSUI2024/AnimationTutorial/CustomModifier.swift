//
//  CustomModifier.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 14.09.2024.
//

import Foundation
import SwiftUI

struct CustomModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        VStack {
            content
            content
        }
    }
    
}
