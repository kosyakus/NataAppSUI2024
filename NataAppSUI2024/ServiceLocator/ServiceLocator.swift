//
//  Untitled.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 25.09.2024.
//

class ServiceLocator {
    static let shared = ServiceLocator()

    private var services: [String: AnyObject] = [:]

    func addService<T>(service: T) {
        let key = String(describing: T.self)
        services[key] = service as AnyObject
    }

    func getService<T>() -> T? {
        let key = String(describing: T.self)
        return services[key] as? T
    }
}
