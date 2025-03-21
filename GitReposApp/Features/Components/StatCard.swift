//
//  StatCard.swift
//  GitReposApp
//
//  Created by Chibueze  Felix Akeredolu on 21/03/2025.
//

import SwiftUI

struct StatCard: View {
    let title: String
    let value: String
    let systemImage: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .font(.title)
                .foregroundColor(color)
            
            Text(value)
                .font(.headline)
                .padding(.top, 4)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
        )
    }
}
