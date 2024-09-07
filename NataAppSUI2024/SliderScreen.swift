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
    
    @Binding var value: Float  // Привязка значения из SwiftUI
    
    class Coordinator: NSObject {
        var parent: SliderScreen

        init(parent: SliderScreen) {
            self.parent = parent
        }
        
        // Обработка изменения значения слайдера
        @objc func valueChanged(_ sender: UISlider) {
            parent.value = sender.value
        }
    }
    
    // Создание координатора
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // Создание UIView (UISlider)
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)
        return slider
    }
    
    // Обновление UIView
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }
}

