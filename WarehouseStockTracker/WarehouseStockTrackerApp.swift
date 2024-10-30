//
//  WarehouseStockTrackerApp.swift
//  WarehouseStockTracker
//
//  Created by Alex on 9/10/2024.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore

@main
struct WarehouseStockTrackerApp: App {
    
    init() {
        FirebaseApp.configure()
        // call migration func for SwiftData -> Firestore
        
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WarehouseProduct.self,
            Supplier.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomePage()
        }
        .modelContainer(sharedModelContainer)
    }
    
}
