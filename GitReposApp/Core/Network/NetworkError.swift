//
//  NetworkError.swift
//  GitReposApp
//
//  Created by Chibueze  Felix on 21/03/2025.
//



import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}



