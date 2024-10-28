//
//  HomePage.swift
//  WarehouseStockTracker
//
//  Created by Alex on 19/10/2024.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationStack {
            VStack {
                // Company name title
                Text("Hospitality Disposables")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 50)
                    
                // Company image/logo
                // cube.box person
                    
                HStack {
                    Image(
                        systemName: "person"
                    ) // Placeholder image, you can replace with your logo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.blue)
                    .padding(.bottom, 50)
                    Image(
                        systemName: "cube.box"
                    ) // Placeholder image, you can replace with your logo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.blue)
                    .padding(.bottom, 50)
                    Image(
                        systemName: "person"
                    ) // Placeholder image, you can replace with your logo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.blue)
                    .padding(.bottom, 50)
                }
                    
                // Button to navigate to the login page
                NavigationLink(destination: SignInView()) {
                    Text("Go to Login page")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)  // Adjust padding for desired button size
            }
            .padding()
        }
    }
}

#Preview {
    HomePage()
        .modelContainer(SampleData.shared.modelContainer)
}
