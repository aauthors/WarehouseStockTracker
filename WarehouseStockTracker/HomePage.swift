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
                ZStack {
                    Group {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.blue, .cyan]),
                                    startPoint: .center,
                                    endPoint: .top
                                )
                            )
                            .foregroundStyle(.blue)
                            .opacity(0.3)
                            .shadow(color: .gray, radius: 10, x: 0, y: 8)
                        
                        Text("Hospitality Disposables")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                    }
                    .padding(.bottom, 80)

                }
                .padding(.top, 80)
                .padding(.bottom, 80)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .animation(.easeInOut(duration: 1.5), value: 1)
                
                // Company image/logo
                // cube.box person
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, Color(white: 0.5)]),
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        )
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.2)
                        
                    HStack {
                        Image(
                            systemName: "person"
                        ) // Placeholder image, you can replace with your logo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Color(white: 0.288))
                        .padding(.bottom, 50)
                        Image(
                            systemName: "cube.box"
                        ) // Placeholder image, you can replace with your logo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Color(white: 0.288))
                        .padding(.bottom, 50)
                        Image(
                            systemName: "person"
                        ) // Placeholder image, you can replace with your logo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Color(white: 0.288))
                        .padding(.bottom, 50)
                    }
                }
                
                // Button to navigate to the login page
                NavigationLink(destination: SignInView()) {
                    Text("Go to Login page")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .cyan]),
                                startPoint: .center,
                                endPoint: .top
                            )
                        )
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)  // Adjust padding for desired button size
                .buttonStyle(.plain)
                
            }
            .padding()
        }
    }
}

#Preview {
    HomePage()
        .modelContainer(SampleData.shared.modelContainer)
}
