//
//  CartItem.swift
//  QuickCash
//
//  Created by Meet Patel on 08/03/25.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    var product: Product
    var quantity: Int
}
