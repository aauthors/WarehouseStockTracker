//
//  ProductSummary.swift
//  WarehouseStockTracker
//
//  Created by Alex on 14/10/2024.
//

import SwiftUI
import SwiftData

struct ProductSummary: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // variable to pop up alert
    @State private var showAlert = false
    
    var productList: [WarehouseProduct]
    
    // making a variable for copy and pasting text
    var stringFormatOfProducts: String = ""
    
    init(productList: [WarehouseProduct]) {
        self.productList = productList
    }
    
    // order by qty
    private var listOrderedByQuantity: [WarehouseProduct] {
        productList.sorted { first, second in
            first.qty > second.qty
        }
    }
    
    var body: some View {
        Group{
            List {
                if !listOrderedByQuantity.isEmpty {
                    NavigationLink {
                        GeneratedListOfProducts(productList: listOrderedByQuantity)
                    } label: {
                        Text("Generate")
                    }
                    ForEach (listOrderedByQuantity) { product in
                        HStack {
                            Text("Code: \(product.code)")
                            
                            Spacer()
                            
                            Text("Qty: \(product.qty)")
                        }
                    }
                } else {
                    ContentUnavailableView {
                        Label("No Products Listed", systemImage: "person")
                    }
                }
                    
            }
            .navigationTitle("Product List Summary")
            
            // Button to clear all products
            Button(action: {
                showAlert = true
            }) {
                Text("Clear Qtys")
            }
            .padding()
            .buttonStyle(.bordered)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Confirm"), message: Text("Are you sure you want to clear all quantities?"), primaryButton: .destructive(Text("Clear")) {
                    for item in productList {
                        item.qty = 0
                    }
                }, secondaryButton: .cancel())
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProductSummary(productList: WarehouseProduct.sampleData)
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty List") {
    NavigationStack {
        ProductSummary(productList: [])
            .modelContainer(SampleData.shared.modelContainer)
    }
}
