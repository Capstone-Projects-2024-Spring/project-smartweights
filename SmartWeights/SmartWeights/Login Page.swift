//
//  LoginView.swift
//  SmartWeights
//
//  Created by par chea on 2/14/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var showingAlert = false // For testing the sign in button
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue
                .opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // App title
                Text("Smart Weight")
                    .font(.system(size: 50))
                    .foregroundStyle(.white)
                    .italic()
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                
                // Logo with rounded corners
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 450, height: 350) // Adjust the size as needed
                    .cornerRadius(50) // Rounded corners
                    .shadow(radius: 10) // Add shadow
                    .padding(.bottom, 20)
                
                // Sign In with Apple Button
                SignInWithAppleButton(.signIn) { request in
                    // Configuration for the request here
                } onCompletion: { result in
                    switch result {
                    case .success(_):
                        alertMessage = "Sign in successful!"
                    case .failure(_):
                        alertMessage = "Sign in failed."
                    }
                    showingAlert = true
                }
                .signInWithAppleButtonStyle(.black) // Adjust the style
                .frame(width: 280, height: 45)
                .shadow(radius: 5) // Add shadow
                .padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Sign In"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


#Preview {
    LoginView()
}
