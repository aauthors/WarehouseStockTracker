//
//  ContentView.swift
//  WarehouseStockTracker
//
//  Created by Alex on 28/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomePage()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
