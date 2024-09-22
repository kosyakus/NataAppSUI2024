//
//  UIView+UIImage.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 22.09.2024.
//

import Foundation
import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
