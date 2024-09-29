//
//  CharactersAPIService.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 25.09.2024.
//

import Combine
import Foundation

protocol CharactersAPIProtocol {
    func getAllCharacters(page: Int) -> AnyPublisher<[ModelCharacter], Error>
}

class CharactersAPIService: CharactersAPIProtocol {
    
    func getAllCharacters(page: Int) -> AnyPublisher<[ModelCharacter], Error> {
        // Оборачиваем асинхронный метод в Combine Publisher с использованием Future
        return Future<[ModelCharacter], Error> { promise in
            Task {
                do {
                    let result = try await CharactersAPI.getAllCharacters(page: page)
                    let characters = result.results ?? []
                    promise(.success(characters))  // Возвращаем успешный результат
                } catch {
                    promise(.failure(error))  // Возвращаем ошибку, если она произошла
                }
            }
        }
        .eraseToAnyPublisher()  // Преобразуем в AnyPublisher
    }
}
