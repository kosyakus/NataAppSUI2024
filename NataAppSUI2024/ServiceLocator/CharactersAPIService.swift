//
//  CharactersAPIService.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 25.09.2024.
//

import Foundation

protocol CharactersAPIProtocol {
    func getAllCharacters(page: Int) async throws -> [ModelCharacter]
}

class CharactersAPIService: CharactersAPIProtocol {
    func getAllCharacters(page: Int) async throws -> [ModelCharacter] {
        // Вызов твоего существующего API
        guard let result = try? await CharactersAPI.getAllCharacters(page: page) else {
            throw URLError(.badServerResponse) // или любой другой тип ошибки
        }
        return result.results ?? []
    }
}
