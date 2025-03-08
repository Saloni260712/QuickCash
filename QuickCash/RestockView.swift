//
//  RestockView.swift
//  QuickCash
//
//  Created by Meet Patel on 15/02/25.
//
import SwiftUI

struct RestockView: View {
    @ObservedObject var viewModel: CashRegisterViewModel
    @State private var selectedProductIndex: Int = 0
    @State private var restockQuantity: Int = 1
    @State private var showRestockAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.teal]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Restock Items")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Picker("Select Product", selection: $selectedProductIndex) {
                    ForEach(viewModel.products.indices, id: \.self) { index in
                        Text(viewModel.products[index].name).tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.2)))
                
                Stepper("Quantity: \(restockQuantity)", value: $restockQuantity, in: 1...100)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.2)))
                    .foregroundColor(.white)
                
                Button(action: {
                    viewModel.restockProduct(at: selectedProductIndex, amount: restockQuantity)
                    showRestockAlert = true  // Show success alert
                    restockQuantity = 1  // Reset Quantity After Restocking
                }) {
                    Text("Restock")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                .alert(isPresented: $showRestockAlert) {  // Restock success message
                    Alert(title: Text("Restocked"),
                          message: Text("\(viewModel.products[selectedProductIndex].name) stock increased!"),
                          dismissButton: .default(Text("OK")))
                }
            }
            .padding()
        }
    }
}
