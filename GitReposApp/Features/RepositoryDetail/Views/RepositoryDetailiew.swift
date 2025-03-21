//
//  RepositoryDetailiew.swift
//  GitReposApp
//
//  Created by Chibueze Felix on 21/03/2025.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    AsyncImage(url: URL(string: repository.owner.avatarUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(repository.fullName)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Owner: \(repository.owner.login)")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                
                if let description = repository.description, !description.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.headline)
                        
                        Text(description)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    Text("Stats")
                        .font(.headline)
                    
                    HStack {
                        StatCard(
                            title: "Stars",
                            value: "",
                            systemImage: "star.fill",
                            color: .yellow
                        )
                        
                        StatCard(
                            title: "Forks",
                            value: "",
                            systemImage: "tuningfork",
                            color: .green
                        )
                        
//                        if let language = repository.language {
//                            StatCard(
//                                title: "Language",
//                                value: language,
//                                systemImage: "chevron.left.forwardslash.chevron.right",
//                                color: .blue
//                            )
//                        }
                    }
                }
                .padding(.horizontal)
                
                Button {
                    if let url = URL(string: repository.htmlUrl) {
                        openURL(url)
                    }
                } label: {
                    HStack {
                        Image(systemName: "safari")
                        Text("Open in GitHub")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
            }
        }
        .navigationTitle("Repository Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
 
