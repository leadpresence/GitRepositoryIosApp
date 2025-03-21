//
//  ReposotoryCell.swift
//  GitReposApp
//
//  Created by Chibueze felix Akeredolu on 21/03/2025.
//
import SwiftUI

struct RepositoryRow: View {
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                AsyncImage(url: URL(string: repository.owner.avatarUrl)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(repository.name)
                        .font(.headline)
                    
                    Text("by \(repository.owner.login)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            if let description = repository.description, !description.isEmpty {
                Text(description)
                    .font(.body)
                    .lineLimit(2)
                    .padding(.top, 4)
            }
            
            HStack {
                Label("0", systemImage: "star.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)
                
                Label("0", systemImage: "tuningfork")
                    .font(.caption)
                    .foregroundColor(.gray)
                
//                if let language = repository.language {
//                    Text(language)
//                        .font(.caption)
//                        .padding(.horizontal, 8)
//                        .padding(.vertical, 2)
//                        .background(Color.blue.opacity(0.2))
//                        .cornerRadius(4)
//                }
            }
        }
        .padding(.vertical, 8)
    }
}

