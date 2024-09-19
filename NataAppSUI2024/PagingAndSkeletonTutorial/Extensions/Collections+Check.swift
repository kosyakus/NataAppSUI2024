//
//  Collections+Check.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import Foundation

extension RandomAccessCollection where Self.Element: Identifiable {
    
    func needToLoad<Item: Identifiable>(_ element: Item) -> Bool {
        guard isEmpty == false else { return false }
        guard let itemIndex = firstIndex(where: {
            AnyHashable($0.id) == AnyHashable(element.id)
        }) else { return false }
        
        // если нужный элемент нашли, то надо понять, насколько он далеко от края массива, чтобы продолжить загрузку
        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 1 // насколько заранее будет
    }
}
