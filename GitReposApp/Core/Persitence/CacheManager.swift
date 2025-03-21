//
//  CacheManager.swift
//  GitReposApp
//
//  Created by Kehinde Akeredolu on 21/03/2025.
//

import Foundation

final class CacheManager {
    static let shared = CacheManager()
    
    private let cacheDirectory: URL
    private let fileManager = FileManager.default
    
    private init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("github_repositories")
        
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    func cacheRepositories(_ repositories: [Repository]) {
        let cacheFile = cacheDirectory.appendingPathComponent("repositories.json")
        
        do {
            let data = try JSONEncoder().encode(repositories)
            try data.write(to: cacheFile)
        } catch {
            print("Error caching repositories: \(error)")
        }
    }
    
    func loadCachedRepositories() -> [Repository]? {
        let cacheFile = cacheDirectory.appendingPathComponent("repositories.json")
        
        guard fileManager.fileExists(atPath: cacheFile.path) else { return nil }
        
        do {
            let data = try Data(contentsOf: cacheFile)
            return try JSONDecoder().decode([Repository].self, from: data)
        } catch {
            print("Error loading cached repositories: \(error)")
            return nil
        }
    }
}
