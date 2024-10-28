//
//  MainPage.swift
//  WarehouseStockTracker
//
//  Created by Alex on 9/10/2024.
//

import FirebaseAuth
import SwiftUI

struct MainPage: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isLoggedOut = false // for successful logout
    @State private var signOutError: String = ""
    @State private var showSignOutError = false
    
    var body: some View {
        NavigationView {
            TabView {
                // put the signout page here
                
                FilteredSupplierList()
                    .tabItem {
                        Label(
                            "Supplier",
                            systemImage: "shippingbox.fill"
                        )
                    }
                            
                FilteredProductList()
                    .tabItem {
                        Label(
                            "Product",
                            systemImage: "suitcase.cart.fill"
                        )
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sign out") {
                        signOutUser()
                    }
                }
            }
            .alert("Sign out error", isPresented: $showSignOutError) {
                Button("OK", role: .cancel) { }
            } message: {
                    Text("error: \(signOutError)")
            }
            .fullScreenCover(isPresented: $isLoggedOut) {
                HomePage()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func signOutUser() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isLoggedOut = true
            }
        } catch {
            signOutError = error.localizedDescription
            print("sign out error: \(signOutError)")
            showSignOutError = true
        }
    }
}


#Preview {
    MainPage()
        .modelContainer(SampleData.shared.modelContainer)
}
