//
//  LoadingModifier.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import Foundation
import SwiftUI

struct LoadingModifier: ViewModifier {
    
    let withLoading: Bool
    
    func body(content: Content) -> some View {
        if withLoading {
            VStack {
                content
                Divider()
                Spacer()
                ProgressView()
                    .progressViewStyle(.linear)
                Spacer()
            }
        } else {
            content
        }
    }
}
