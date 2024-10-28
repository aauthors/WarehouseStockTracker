//
//  Supplier.swift
//  WarehouseStockTracker
//
//  Created by Alex on 11/10/2024.
//

import Foundation
import SwiftData

@Model
final class Supplier {
    var name: String
    var products = [WarehouseProduct]()
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData: Set = [
        Supplier(name: "DetPak"),
        Supplier(name: "PacTrading"),
        Supplier(name: "GenFac Plastics"),
        Supplier(name: "Anchor Packaging"),
        Supplier(name: "LongImport"),
        Supplier(name: "Bio Plastics"),
    ]
}
