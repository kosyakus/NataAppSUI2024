//
//  ShapeExample.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 14.09.2024.
//

import Foundation
import SwiftUI

struct ShapeExample: Shape {
    
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        return Path() { path in
            if rect.width > rect.height {
                path.move(to: CGPoint(x: center.x, y: 0))
                let startAngle = Angle(degrees: 270)
                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: startAngle + Angle(degrees: 360), clockwise: false)
            } else {
                path.move(to: CGPoint(x: 0, y: center.y))
                let startAngle = Angle(degrees: 0)
                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: startAngle + Angle(degrees: 360), clockwise: false)
            }
            path.closeSubpath()
        }
    }
    
}
