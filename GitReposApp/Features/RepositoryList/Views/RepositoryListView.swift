//
//  RepositoryListView.swift
//  GitReposApp
//
//  Created by Chibueze Felix Akeredolu on 21/03/2025.
//


import SwiftUI

struct RepositoryListView: View {
    @StateObject private var viewModel = RepositoryListViewModel()
    @State private var showingDetailView = false
    @State private var selectedRepository: Repository?
    
    var body: some View {
        NavigationView {
            ZStack {
                
//                Table(viewModel.repositories){
//                    TableColumn("Name", value:\.fullName)
//                    TableColumn("Descrption", value: \.blobsUrl)
//                }
                List {
                    ForEach(viewModel.repositories) { repository in
                        RepositoryRow(repository: repository)
                            .onTapGesture {
                                selectedRepository = repository
                                showingDetailView = true
                            }
                    }
                    
                    if viewModel.hasMoreData && !viewModel.repositories.isEmpty {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        .onAppear {
                            Task {
                                await viewModel.loadRepositories()
                            }
                        }
                    }
                }
                .refreshable {
                    await viewModel.loadRepositories(refresh: true)
                }
                .navigationTitle("GitHub Repositories")
                .background(
                    NavigationLink(
                        destination: selectedRepository.map { RepositoryDetailView(repository: $0) },
                        isActive: $showingDetailView
                    ) {
                        EmptyView()
                    }
                )
                
                if viewModel.isLoading && viewModel.repositories.isEmpty {
                    ProgressView()
                        .scaleEffect(1.5)
                }
                
                if let error = viewModel.error, viewModel.repositories.isEmpty {
                    VStack {
                        Text("😿 Something went wrong")
                            .font(.title)
                            .padding(.bottom)
                        
                        Text(error)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button("Try Again") {
                            Task {
                                await viewModel.loadRepositories(refresh: true)
                            }
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding()
                }
            }
        }
        .task {
            viewModel.loadCachedRepositoriesIfNeeded()
            if viewModel.repositories.isEmpty {
                await viewModel.loadRepositories()
            }
        }
    }
}
