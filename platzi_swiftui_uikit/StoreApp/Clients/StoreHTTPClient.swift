//
//  StoreHTTPClient.swift
//  StoreApp
//
//  Created by Mohammad Azam on 11/28/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case decodingError
}

class StoreHTTPClient {
    
    func getAllCategories() async throws -> [Category] {
        
        let (data, response) = try await URLSession.shared.data(from: URL.allCategories)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        
        guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return categories
        
    }
    
}
