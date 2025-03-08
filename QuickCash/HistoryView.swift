//
//  HistoryView.swift
//  QuickCash
//
//  Created by Meet Patel on 15/02/25.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: CashRegisterViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Purchase History")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    if viewModel.purchasedProducts.isEmpty {
                        Text("No purchases yet.")
                            .font(.title2)
                            .foregroundColor(.yellow)
                            .padding()
                    } else {
                        List(viewModel.purchasedProducts, id: \.id) { product in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(product.name)  // how Product Name
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                    
                                    HStack {
                                        Text("Qty: \(product.quantity)")
                                            .foregroundColor(.yellow)
                                        Spacer()
                                        Text("Total: $\(String(format: "%.2f", product.price * Double(product.quantity)))")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.2)))
                            }
                        }
                        .listRowBackground(Color.black.opacity(0.2))
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
