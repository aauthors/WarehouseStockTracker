//
//  SignInView.swift
//  WarehouseStockTracker
//
//  Created by Alex on 19/10/2024.
//
 
import SwiftUI
import FirebaseAuth

struct SignInView: View {
    // State variables to hold user input
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            
            VStack {
                // Sign-in Header
                Text("Sign In")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                    
                // Email TextField
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress) // Keyboard with "@" symbol
                    .autocapitalization(.none)  // No auto capitalisation for email
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    
                // Password SecureField
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)

                // Sign-in Button
                // Button to navigate to the login page
                Group {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 40)
                            .foregroundStyle(.blue)
                        
                        Button(action: signInUser) {
                            Text("Sign In")
                                .foregroundStyle(.white)
                        }
                        .navigationDestination(isPresented: $isLoggedIn) {
                            MainPage()
                        }

                    }
                }
                
                // Error message display
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
    }
    
    // Function to handle sign-in logic
    private func signInUser() {
        // Basic email and password validation
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter both email and password."
            showError = true
        } else {
            // Here you would usually call your authentication API.
            // For now, we will simulate successful or failed login
            Auth
                .auth()
                .signIn(
                    withEmail: email,
                    password: password
                ) { authResult, error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                        showError = true
                    } else {
                        showError = false
                        isLoggedIn = true
                        print("User logged in successfully.")
                    }
                
                }
        }
    }
}

#Preview {
    SignInView()
        .modelContainer(SampleData.shared.modelContainer)
}
