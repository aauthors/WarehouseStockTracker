//
//  SampleData.swift
//  WarehouseStockTracker
//
//  Created by Alex on 9/10/2024.
//

import Foundation
import SwiftData
import FirebaseFirestore

@MainActor
class SampleData {
    // creating a mocdel container that provides sample data
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
   
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private let db = Firestore.firestore()
    
    // mark initialiser as private so can only create instances inside the smapledata class.
    private init() {
        let schema = Schema([
            WarehouseProduct.self,
            Supplier.self,
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        
        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            
            // insert sample data
            insertSampleData()
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
    }
    
    // fetch products from Firestore
    
    func migrateDataToFirestoreIfNeeded() {
        // call your migration logic here
        migrateDataToFirestore()
    }
    
    func fetchItemsFromSwiftData() -> ([WarehouseProduct], [Supplier]) {
        var products: [WarehouseProduct] = []
        var suppliers: [Supplier] = []

        // Fetch all WarehouseProduct items
        let productFetchDescriptor = FetchDescriptor<WarehouseProduct>()
        do {
            products = try context.fetch(productFetchDescriptor)
        } catch {
            print(
                "Failed to fetch WarehouseProduct items from SwiftData: \(error)"
            )
        }

        // Fetch all Supplier items
        let supplierFetchDescriptor = FetchDescriptor<Supplier>()
        do {
            suppliers = try context.fetch(supplierFetchDescriptor)
        } catch {
            print("Failed to fetch Supplier items from SwiftData: \(error)")
        }

        return (products, suppliers)
    }
    
    func migrateDataToFirestore() {
        let (products, suppliers) = fetchItemsFromSwiftData()
        let db = Firestore.firestore()
            
        // Migrate products
        let productsRef = db.collection("sharedData").document("products")
        for product in products {
            do {
                try productsRef
                    .collection("items")
                    .document()
                    .setData(from: product)
            } catch let error {
                print("Error migrating product: \(error)")
            }
        }
            
        // Migrate suppliers
        let suppliersRef = db.collection("sharedData").document("suppliers")
        for supplier in suppliers {
            do {
                try suppliersRef
                    .collection("items")
                    .document()
                    .setData(from: supplier)
            } catch let error {
                print("Error migrating supplier: \(error)")
            }
        }
    }
    
    func insertSampleData() {
        for product in WarehouseProduct.sampleData {
            context.insert(product)
        }
        
        for supplier in Supplier.sampleData {
            context.insert(supplier)
        }
        
        // create relationships after data insertion
        
        
        
        // attempt to save the model context after insertion
        do {
            try context.save()
        } catch {
            print("Sample data failed to save in SampleData.swift")
        }
    }
    
    // computed value for a product.
    var product: WarehouseProduct {
        WarehouseProduct.sampleData[0]
    }
    
    var supplier: Supplier {
        let arrayOfSuppliers = Array(Supplier.sampleData)
        return arrayOfSuppliers[0]
    }
    
}
