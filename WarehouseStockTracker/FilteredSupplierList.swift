//
//  FilteredSupplierList.swift
//  WarehouseStockTracker
//
//  Created by Alex on 13/10/2024.
//

import SwiftUI
import FirebaseAuth

struct FilteredSupplierList: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            SupplierList(titleFilter: searchText)
                .searchable(text: $searchText)
        }
    }
}

#Preview {
    NavigationStack {
        FilteredSupplierList()
    }
    .modelContainer(SampleData.shared.modelContainer)
}
