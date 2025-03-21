//
//  CacheManager.swift
//  GitReposApp
//
//  Created by Chibueze  Felix on 21/03/2025.
//

 
// CacheService.swift - Handles local data caching
import Foundation

class CacheService {
    static let shared = CacheService()
    private let userDefaults = UserDefaults.standard
    private let repositoriesKey = "cachedRepositories"
    
    private init() {}
    
    func cacheRepositories(_ repositories: [Repository]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(repositories)
            userDefaults.set(data, forKey: repositoriesKey)
        } catch {
            print("Error caching repositories: \(error)")
        }
    }
    
    func getCachedRepositories() -> [Repository]? {
        guard let data = userDefaults.data(forKey: repositoriesKey) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Repository].self, from: data)
        } catch {
            print("Error retrieving cached repositories: \(error)")
            return nil
        }
    }
}
