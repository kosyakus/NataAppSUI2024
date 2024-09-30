// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol StorageServiceProtocol {
    func save<T: Codable>(_ object: T, forKey key: String) throws
    func load<T: Codable>(forKey key: String, as type: T.Type) throws -> T?
}

public class StorageService: StorageServiceProtocol {
    
    public init() {}
    
    public func save<T: Codable>(_ object: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(object)
        UserDefaults.standard.set(data, forKey: key)
    }

    public func load<T: Codable>(forKey key: String, as type: T.Type) throws -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
