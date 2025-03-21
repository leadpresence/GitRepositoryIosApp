//
//  RepositoryListViewModel.swift
//  GitReposApp
//
//  Created by chibueze Felix on 21/03/2025.
//
 
import Foundation
import SwiftUI

class RepositoryListViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var isLoading = false
    @Published var error: String?
    @Published var hasMoreData = true
    private var currentPage = 1
    private let pageSize = 30
    
    func loadRepositories(refresh: Bool = false) async {
        if refresh {
            currentPage = 1
            hasMoreData = true
        }
        
        if isLoading || (!refresh && !hasMoreData) {
            return
        }
        
        await MainActor.run {
            isLoading = true
            error = nil
        }
        
        do {
            let newRepositories = try await NetworkService.shared.fetchRepositories(
                page: refresh ? 1 : repositories.last?.id ?? 0,
                perPage: pageSize
            )
            
            await MainActor.run {
                if refresh {
                    self.repositories = newRepositories
                } else {
                    self.repositories.append(contentsOf: newRepositories)
                }
                
                self.hasMoreData = !newRepositories.isEmpty
                
                if !newRepositories.isEmpty {
                    CacheService.shared.cacheRepositories(self.repositories)
                }
                
                self.isLoading = false
                self.currentPage += 1
            }
        } catch {
            await MainActor.run {
                self.error = "Failed to load repositories: \(error.localizedDescription)"
                self.isLoading = false
                
                // Try to load from cache if this is the first load
                if self.repositories.isEmpty {
                    if let cached = CacheService.shared.getCachedRepositories() {
                        self.repositories = cached
                        self.error = "Showing cached data. Pull to refresh."
                    }
                }
            }
        }
    }
    
    func loadCachedRepositoriesIfNeeded() {
        if repositories.isEmpty {
            if let cached = CacheService.shared.getCachedRepositories() {
                repositories = cached
            }
        }
    }
}
