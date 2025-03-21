//
//  Endpoint.swift
//  GitReposApp
//
//  Created by Chibueze Felix on 21/03/2025.
//
import Foundation
enum Endpoint {
    case repositories(page: Int, perPage: Int)
    
    var url: URL? {
        switch self {
        case .repositories(let page, let perPage):
            var components = URLComponents(string: "https://api.github.com/repositories")
            components?.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "\(perPage)")
            ]
            return components?.url
        }
    }
}
