//
//  WarehouseProduct.swift
//  WarehouseStockTracker
//
//  Created by Alex on 9/10/2024.
//

import Foundation
import SwiftData

@Model
final class WarehouseProduct {
    var timestamp: Date
    var code: String
    var supplier: Supplier?
    var qty: Int
    
    init(timestamp: Date, code: String, qty: Int) {
        self.timestamp = timestamp
        self.code = code
        self.qty = qty
    }
    
    static let sampleData = [
        WarehouseProduct(timestamp: Date(), code: "PT-HL8B", qty: 4),
        WarehouseProduct(timestamp: Date(), code: "DP-HL8W", qty: 3),
        WarehouseProduct(timestamp: Date(), code: "GF-REC500", qty: 2),
        WarehouseProduct(timestamp: Date(), code: "PT-HL1216B", qty: 1),
        WarehouseProduct(timestamp: Date(), code: "PT-HL1216W", qty: 1),
    ]
}
