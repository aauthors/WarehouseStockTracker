//
//  GeneratedListOfProducts.swift
//  WarehouseStockTracker
//
//  Created by Alex on 14/10/2024.
//

import SwiftUI
import SwiftData

struct GeneratedListOfProducts: View {
    
    private var stringFormatOfProducts: String = ""
    private var productList: [WarehouseProduct] = []
    
    // Envirion Vals
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    init(productList: [WarehouseProduct]) {
        self.productList = productList
    }
    
    var curString: String {
        var str: String = "Missing Stock\n"
        for product in productList {
            if (product.qty != 0) {
                str += "\(product.code) \t ====> \t \(product.qty)\n"
            }
        }
        return str
    }
    
    var body: some View {
        Divider()
        
        if curString.isEmpty {
            Text("Ooops, looks like there\n aren't any products listed")
                .navigationTitle("Products???")
        } else {
            Text(curString)
                .textSelection(.enabled)
                .textEditorStyle(.plain)
                .navigationTitle("Formatted Products")
        }
        
        Spacer()
    }
}

#Preview {
    NavigationStack {
        GeneratedListOfProducts(productList: [])
            .modelContainer(SampleData.shared.modelContainer)
    }
}
