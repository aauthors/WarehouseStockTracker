//
//  ProductDetail.swift
//  WarehouseStockTracker
//
//  Created by Alex on 11/10/2024.
//

import SwiftUI
import SwiftData

struct ProductDetail: View {
    
    // variable that I want to create a view for
    @Bindable var product: WarehouseProduct
    var isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    //NOTE: Come back to this so I can continue on after creating a Supplier
    @Query(sort: \Supplier.name) private var suppliers: [Supplier]
    
    init(product: WarehouseProduct, isNew: Bool = false) {
        self.product = product
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            let stringValue = String(product.qty)
            HStack {
                TextField("Code", text: $product.code)
                Text(stringValue)
            }
            
            Picker("Current Supplier", selection: $product.supplier) {
                
                // if no supplier has been set
                Text("No Supplier Set")
                // using a tag gives us a hashable thingy to help identify the views.
                    .tag(nil as Supplier?)
                
                ForEach (suppliers) { supplier in
                    Text(supplier.name)
                        .tag(supplier as Supplier?)
                }
                
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(.teal)
                    .frame(alignment: .center)
                
                Text(stringValue)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
            }
            
        }
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        
        Spacer()
        
        HStack {
            Spacer()
            Button("- Qty", action: removeQty)
                .buttonStyle(.bordered)
                .padding()
            Spacer()
            Button("+ Qty", action: addQty)
                .buttonStyle(.borderedProminent)
                .padding()
            Spacer()
        }
        
    }
    
    // function for adding to the qty
    private func addQty() {
        product.qty += 1
    }
    
    // function for removing the qty
    private func removeQty() {
        product.qty -= 1
    }
}

#Preview {
    NavigationStack{
        ProductDetail(product: SampleData.shared.product)
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("New Product") {
    NavigationStack {
        ProductDetail(product: SampleData.shared.product, isNew: true)
            .navigationBarTitleDisplayMode(.inline)
    }
}
