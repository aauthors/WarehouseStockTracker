//
//  FilteredProductList.swift
//  WarehouseStockTracker
//
//  Created by Alex on 13/10/2024.
//

import SwiftUI
import FirebaseAuth

struct FilteredProductList: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ProductList(titleFilter: searchText)
                .searchable(text: $searchText)
        }
    }
}

#Preview {
    NavigationStack {
        FilteredProductList()
    }
    .modelContainer(SampleData.shared.modelContainer)
}
