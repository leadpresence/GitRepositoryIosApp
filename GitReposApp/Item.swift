//
//  Item.swift
//  GitReposApp
//
//  Created by chibueze Felix 21/03/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
