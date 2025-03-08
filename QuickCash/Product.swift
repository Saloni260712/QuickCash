//
//  Product.swift
//  QuickCash
//
//  Created by Meet Patel on 14/02/25.
//

import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var quantity: Int
    var price: Double
    
    // Conforming to Hashable
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

