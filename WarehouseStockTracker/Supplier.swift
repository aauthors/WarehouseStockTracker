//
//  Supplier.swift
//  WarehouseStockTracker
//
//  Created by Alex on 11/10/2024.
//

import Foundation
import SwiftData

@Model
final class Supplier: Encodable {
    // updating model to conform to encodable via UUID()
    var id: UUID
    var name: String
    var products = [WarehouseProduct]()
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    static let sampleData: Set = [
        Supplier(id: UUID(), name: "DetPak"),
        Supplier(id: UUID(), name: "PacTrading"),
        Supplier(id: UUID(), name: "GenFac Plastics"),
        Supplier(id: UUID(), name: "Anchor Packaging"),
        Supplier(id: UUID(), name: "LongImport"),
        Supplier(id: UUID(), name: "Bio Plastics"),
    ]
}
