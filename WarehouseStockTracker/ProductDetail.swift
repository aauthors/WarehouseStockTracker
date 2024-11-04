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
                ZStack {
                    Group {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing)
                            )
                            .opacity(0.2)
                        
                        TextField("Code", text: $product.code)
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                    }
                }
                Spacer()
                ZStack {
                    Group {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing)
                            )
                            .opacity(0.2)
                        
                        Text(stringValue)
                    }
                }
            }
            
            Group {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing)
                        )
                        .opacity(0.2)

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
                    .padding()
                    .font(.headline)
                    .fontWeight(.bold)
                }
            }
            
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .center, endPoint: .bottom)
                    )
                    .opacity(0 + Double(product.qty) * 0.1)
                    .frame(alignment: .center)
                
                Text("\(product.qty)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.black.opacity(0.6))
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
            Group {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(colors: [.red, .red.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                        )
                        .opacity(0.7)
                        .shadow(radius: 4, x:0, y: 2)

                    Button("- Qty", action: removeQty)
                        .fontWeight(.bold)
                        .buttonStyle(.plain)
                }
            }
            .frame(width: 120, height: 60)
            .padding()
            
            Spacer()
            
            Group {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(colors: [.blue, .cyan.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                        )
                        .opacity(0.7)
                        .shadow(radius: 4, x:0, y: 2)

                    Button("+ Qty", action: addQty)
                        .fontWeight(.bold)
                        .buttonStyle(.plain)
                }
            }
            .frame(width: 120, height: 60)
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
