//
//  ProductList.swift
//  WarehouseStockTracker
//
//  Created by Alex on 12/10/2024.
//

import SwiftUI
import SwiftData

struct ProductList: View {
    
    // Environment porperties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var products: [WarehouseProduct]
    
    @State private var newProduct: WarehouseProduct?
    @State private var orderByQty: Bool = false
    
    init(titleFilter: String = "") {
        //
        // providing a predicate to filter with
        //
        let predicate = #Predicate<WarehouseProduct> { product in
            titleFilter.isEmpty || product.code.localizedStandardContains(titleFilter)
        }
        
        _products = Query(filter: predicate, sort: \WarehouseProduct.code)
    }
    
    var productsByQuantity: [WarehouseProduct] {
        products.sorted {$0.qty > $1.qty}
    }
    
    var body: some View {
        Group {
            if !products.isEmpty {
                if orderByQty {
                    List {
                        ForEach (productsByQuantity) { product in
                            NavigationLink(destination: ProductDetail(product: product)) {
                                HStack {
                                    Group {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [.blue, .green]),
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                                .opacity(0.2)
                                            HStack {
                                                Spacer()
                                                Text(product.code)
                                                    .font(.headline)
                                                Spacer()
                                                Text("|")
                                                Spacer()
                                                Text("\(product.qty)")
                                                    .font(.subheadline)
                                                    .fontWeight(.bold)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .navigationTitle("Products by Qty")
                } else {
                    List {
                        ForEach (products) { product in
                            NavigationLink(destination: ProductDetail(product: product)) {
                                HStack {
                                    Group {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [.blue, .green]),
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                                .opacity(0.2)
                                            HStack {
                                                Spacer()
                                                Text(product.code)
                                                    .font(.headline)
                                                Spacer()
                                                Text("|")
                                                Spacer()
                                                Text("\(product.qty)")
                                                    .font(.subheadline)
                                                    .fontWeight(.bold)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Products by Code")
                }
            } else {
                ContentUnavailableView {
                    Label("No Products to Display", systemImage: "suitcase.cart.fill")
                }
            }
        }
        .navigationTitle("Products")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            
            ToolbarItem {
                Button(action: addProduct) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(item: $newProduct) { product in
            NavigationStack {
                ProductDetail(product: product, isNew: true)
            }
            .interactiveDismissDisabled()
        }
        HStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 150, height: 40)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .cyan]),
                            startPoint: .center,
                            endPoint: .top
                        )
                    )
                
                Toggle("Order by Qty", isOn: $orderByQty)
                    .foregroundStyle(.white)
                    .buttonStyle(.plain)
                    .toggleStyle(.button)
            }
            
            Spacer()
            
                
            NavigationLink(destination: ProductSummary(productList: products)) {
                Text("Summary")
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: 150, height: 40)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 40)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .cyan]),
                    startPoint: .center,
                    endPoint: .top
                )
            )
            .cornerRadius(10)
            .buttonStyle(.plain)
            
            Spacer()
        }
    }
    
    
    // functions for adding and editing
    private func addProduct() {
        withAnimation {
            let newItem = WarehouseProduct(timestamp: .now, code: "", qty: 0)
            modelContext.insert(newItem)
            newProduct = newItem
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(products[index])
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProductList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty List") {
    NavigationStack {
        ProductList()
            .modelContainer(for: WarehouseProduct.self, inMemory: true)
    }
}

#Preview("Filtered") {
    NavigationStack {
        ProductList(titleFilter: "")
            .modelContainer(SampleData.shared.modelContainer)
    }
}
