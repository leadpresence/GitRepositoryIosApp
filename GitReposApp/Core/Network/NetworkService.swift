//
//  NetworkManager.swift
//  GitReposApp
//
//  Created by Kehinde Akeredolu on 21/03/2025.
//
import Foundation
class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchRepositories(page: Int = 1, perPage: Int = 30) async throws -> [Repository] {
        guard let url = URL(string: "https://api.github.com/repositories?since=\(page)&per_page=\(perPage)") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            return try JSONDecoder().decode([Repository].self, from: data)
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(error)
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
