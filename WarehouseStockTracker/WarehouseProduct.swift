//
//  WarehouseProduct.swift
//  WarehouseStockTracker
//
//  Created by Alex on 9/10/2024.
//

import Foundation
import SwiftData

@Model
final class WarehouseProduct: Encodable {
    // alter the model to conform to Encodable
    var id: UUID
    
    var timestamp: Date
    var code: String
    var supplier: Supplier?
    var qty: Int
    
    init(id: UUID = UUID(), timestamp: Date, code: String, qty: Int) {
        self.id = id
        self.timestamp = timestamp
        self.code = code
        self.qty = qty
    }
    
    // manual encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(code, forKey: .code)
        try container.encode(qty, forKey: .qty)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, timestamp, code, qty
    }
    
    static let sampleData = [
        WarehouseProduct(id: UUID(), timestamp: Date(), code: "PT-HL8B", qty: 4),
        WarehouseProduct(id: UUID(), timestamp: Date(), code: "DP-HL8W", qty: 3),
        WarehouseProduct(id: UUID(), timestamp: Date(), code: "GF-REC500", qty: 2),
        WarehouseProduct(id: UUID(), timestamp: Date(), code: "PT-HL1216B", qty: 1),
        WarehouseProduct(id: UUID(), timestamp: Date(), code: "PT-HL1216W", qty: 1),
    ]
}
