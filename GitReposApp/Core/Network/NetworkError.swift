//
//  NetworkError.swift
//  GitReposApp
//
//  Created by Chibueze  Felix on 21/03/2025.
//

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case serverError(Int)
    case noData
    
    var userMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL. Please try again later."
        case .requestFailed:
            return "Network request failed. Please check your connection."
        case .invalidResponse:
            return "Received an invalid response. Please try again."
        case .decodingFailed:
            return "Failed to process the data. Please try again later."
        case .serverError(let code):
            return "Server error: \(code). Please try again later."
        case .noData:
            return "No data received. Please try again."
        }
    }
}


