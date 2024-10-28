//
//  SupplierDetail.swift
//  WarehouseStockTracker
//
//  Created by Alex on 11/10/2024.
//

import SwiftUI
import SwiftData

struct SupplierDetail: View {
    @Bindable var supplier: Supplier
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Supplier.name) private var suppliers: [Supplier]
    
    init(supplier: Supplier, isNew: Bool = false) {
        self.supplier = supplier
        self.isNew = isNew
    }
    
    
    var body: some View {
        Form {
            TextField("New Supplier", text: $supplier.name)
                .autocorrectionDisabled()
        }
        .navigationTitle(isNew ? "New Supplier" : "Supplier")
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        modelContext.delete(supplier)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SupplierDetail(supplier: SampleData.shared.supplier)
            .navigationBarTitleDisplayMode(.inline)
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("New Supplier") {
    NavigationStack {
        SupplierDetail(supplier: SampleData.shared.supplier, isNew: true)
            .navigationBarTitleDisplayMode(.inline)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
