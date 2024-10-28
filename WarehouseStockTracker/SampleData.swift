//
//  SampleData.swift
//  WarehouseStockTracker
//
//  Created by Alex on 9/10/2024.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    // creating a mocdel container that provides sample data
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
   
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    // mark initialiser as private so can only create instances inside the smapledata class.
    private init() {
        let schema = Schema([
            WarehouseProduct.self,
            Supplier.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            // insert sample data
            insertSampleData()
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
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
