//
//  SliderScreen.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 07.09.2024.
//

import SwiftUI
import UIKit

// UIViewRepresentable для UISlider
struct SliderScreen: UIViewRepresentable {
    
    @Binding var value: Float
    
    class Coordinator: NSObject {
        var parent: SliderScreen

        init(parent: SliderScreen) {
            self.parent = parent
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            parent.value = sender.value
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }
}

