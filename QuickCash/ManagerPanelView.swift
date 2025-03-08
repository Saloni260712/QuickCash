//
//  ManagerPanelView.swift
//  QuickCash
//
//  Created by Meet Patel on 15/02/25.
//

import SwiftUI

struct ManagerPanelView: View {
    @ObservedObject var viewModel: CashRegisterViewModel  // Uses the same instance from ContentView
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("Manager Panel")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: HistoryView(viewModel: viewModel)) {  // ✅ Passes the same viewModel
                        HStack {
                            Image(systemName: "list.bullet.rectangle")
                                .font(.title)
                            Text("View History")
                                .font(.title2)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    }
                    
                    NavigationLink(destination: RestockView(viewModel: viewModel)) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                            Text("Restock Items")
                                .font(.title2)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
    }
}
