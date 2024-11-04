//
//  SupplierList.swift
//  WarehouseStockTracker
//
//  Created by Alex on 12/10/2024.
//

import SwiftUI
import SwiftData

struct SupplierList: View {
    // Environment properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query private var suppliers: [Supplier]
    
    // State properties for the new supplier
    @State private var newSupplier: Supplier?
    
    init(titleFilter: String = "") {
        
        let predicate = #Predicate<Supplier> { supplier in
            titleFilter.isEmpty || supplier.name
                .localizedStandardContains(titleFilter)
        }
        
        _suppliers = Query(filter: predicate, sort: \Supplier.name)
    }
    
    var body: some View {
        Group {
            if !suppliers.isEmpty {
                List {
                    ForEach(suppliers) { supplier in
                        NavigationLink {
                            SupplierDetail(supplier: supplier)
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing)
                                        )
                                        .opacity(0.2)
                                    
                                    Text(supplier.name)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .buttonStyle(.plain)
                .listStyle(PlainListStyle())
                .navigationTitle("Suppliers")
            } else {
                ContentUnavailableView {
                    Label("No Supplier Listed", systemImage: "shippingbox.fill")
                }
            }
        }
        .navigationTitle("Suppliers")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addSupplier) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(item: $newSupplier) { supplier in
            NavigationStack {
                SupplierDetail(supplier: supplier, isNew: true)
            }
            .interactiveDismissDisabled()
        }
    }
    
    // functions to add and delete a supplier
    private func addSupplier() {
        withAnimation {
            let newItem = Supplier(name: "")
            modelContext.insert(newItem)
            newSupplier = newItem
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(suppliers[index])
            }
        }
    }
}

#Preview {
    NavigationStack {
        SupplierList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty List") {
    NavigationStack {
        SupplierList()
            .modelContainer(for: Supplier.self, inMemory: true)
    }
}

#Preview("Filtered") {
    NavigationStack {
        SupplierList(titleFilter: "")
            .modelContainer(SampleData.shared.modelContainer)
    }
}
