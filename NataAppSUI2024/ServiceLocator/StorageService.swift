//
//  StorageService.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 25.09.2024.
//

//import Foundation
//
//protocol StorageServiceProtocol {
//    func save<T: Codable>(_ object: T, forKey key: String) throws
//    func load<T: Codable>(forKey key: String, as type: T.Type) throws -> T?
//}
//
//class StorageService: StorageServiceProtocol {
//    func save<T: Codable>(_ object: T, forKey key: String) throws {
//        let data = try JSONEncoder().encode(object)
//        UserDefaults.standard.set(data, forKey: key)
//    }
//
//    func load<T: Codable>(forKey key: String, as type: T.Type) throws -> T? {
//        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
//        return try JSONDecoder().decode(T.self, from: data)
//    }
//}
