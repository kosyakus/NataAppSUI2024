//
//  Injected.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 25.09.2024.
//

@propertyWrapper
struct Injected<T> {
    private var service: T?

    public init() {
        self.service = ServiceLocator.shared.getService()
    }

    public var wrappedValue: T {
        guard let service = service else {
            fatalError("Dependency \(T.self) not found!")
        }
        return service
    }
}
