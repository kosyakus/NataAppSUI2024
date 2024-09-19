//
//  SkeletonItem.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 19.09.2024.
//

import Foundation

/// для генерации разных айди
class Helper {
    static var lastId = 0
}

struct SkeletonItem: Identifiable, Hashable {
    let id: Int
    var character: ModelCharacter?
    
    init(character: ModelCharacter? = nil) {
        self.id = Helper.lastId
        self.character = character
        
        Helper.lastId += 1
    }
}
