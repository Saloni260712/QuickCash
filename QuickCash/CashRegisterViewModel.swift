//
//  CashRegisterViewModel.swift
//  QuickCash
//
//  Created by Meet Patel on 14/02/25.
//

import Foundation
import SwiftUI

class CashRegisterViewModel: ObservableObject {
    @Published var products: [Product] = [
        Product(name: "Hat", quantity: 10, price: 10.0),
        Product(name: "Shirt", quantity: 15, price: 20.0),
        Product(name: "Jeans", quantity: 5, price: 50.0)
    ]
    
    @Published var purchasedProducts: [Product] = []
    @Published var cart: [CartItem] = []
    
    var totalPrice: Double {
        return cart.reduce(0) { $0 + (Double($1.quantity) * $1.product.price) }
    }
    
    func addToCart(product: Product, quantity: Int) {
        guard quantity > 0, let index = products.firstIndex(where: { $0.id == product.id }) else { return }
        
        if products[index].quantity >= quantity {
            if let cartIndex = cart.firstIndex(where: { $0.product.id == product.id }) {
                cart[cartIndex].quantity += quantity  // Add more quantity if already in cart
            } else {
                cart.append(CartItem(product: product, quantity: quantity))  // Add new product to cart
            }
        }
    }
    func buyProducts() {
        withAnimation {
            for cartItem in cart {
                if let index = products.firstIndex(where: { $0.id == cartItem.product.id }) {
                    products[index].quantity -= cartItem.quantity
                    
                    if let purchaseIndex = purchasedProducts.firstIndex(where: { $0.name == cartItem.product.name }) {
                        purchasedProducts[purchaseIndex].quantity += cartItem.quantity  // Update purchase history
                    } else {
                        purchasedProducts.append(Product(name: cartItem.product.name, quantity: cartItem.quantity, price: cartItem.product.price))
                    }
                }
            }
            cart.removeAll()  // Clear cart after purchase
        }
    }

    
    func restockProduct(at index: Int, amount: Int) {
        if index >= 0 && index < products.count {
            withAnimation {
                products[index].quantity += amount
                products = Array(products)  // Forces SwiftUI to recognize the update
            }
        }
    }
}
