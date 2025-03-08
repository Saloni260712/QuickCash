//
//  ContentView.swift
//  QuickCash
//
//  Created by Meet Patel on 14/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CashRegisterViewModel()
    @State private var showAlert = false  // State to show alert
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("QuickCash Register")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    // Product List with Enhanced UI
                    List(viewModel.products) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Stock: \(product.quantity)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {
                                viewModel.addToCart(product: product, quantity: 1)
                            }) {
                                Image(systemName: "cart.badge.plus")
                                    .foregroundColor(.green)
                                    .padding()
                                    .background(Circle().fill(Color.white.opacity(0.2)))
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0.2)))
                        .shadow(radius: 3)
                    }
                    .frame(maxHeight: 250)
                    .listStyle(PlainListStyle())

                    //  Display Cart Items
                    if !viewModel.cart.isEmpty {
                        VStack {
                            Text("Cart")
                                .font(.title2)
                                .foregroundColor(.white)

                            List(viewModel.cart) { cartItem in
                                HStack {
                                    Text("\(cartItem.product.name)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("Qty: \(cartItem.quantity)")
                                        .foregroundColor(.yellow)
                                }
                            }
                            .frame(maxHeight: 150)
                        }
                        .padding()
                    }
                    
                    Text("Total Price: $\(viewModel.totalPrice, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.yellow)

                    // Buy Now Button with Success Notification
                    Button(action: {
                        viewModel.buyProducts()
                        showAlert = true  // Show success alert
                    }) {
                        Text("Buy Now")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .disabled(viewModel.cart.isEmpty)
                    .padding(.horizontal)
                    .alert(isPresented: $showAlert) {  //  Show success message
                        Alert(title: Text("Success"),
                              message: Text("Your purchase was successful!"),
                              dismissButton: .default(Text("OK")))
                    }

                    //  Navigation to Manager Panel
                    NavigationLink(destination: ManagerPanelView(viewModel: viewModel)) {
                        Text("Manager Panel")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
    }
}
