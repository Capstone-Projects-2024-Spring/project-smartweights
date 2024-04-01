//
//  LoginView.swift
//  SmartWeights
//
//  Created by par chea on 2/14/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showingAlert = false // For testing the sign in button
    @State private var alertMessage = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userID") var userID: String = ""
    @State private var isLoggedIn = false // Tracking login status
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue
                .opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if userID.isEmpty{
                    Spacer()
                    
                    // App title
                    Text("SmartWeights")
                        .font(.system(size: 55))
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
                    SignInWithAppleButton(.continue) { request in
                        // Configuration for the request here
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        switch result {
                        case .success(let auth):
                            if let credential = auth.credential as? ASAuthorizationAppleIDCredential {
                                self.email = credential.email ?? ""
                                self.firstName = credential.fullName?.givenName ?? ""
                                self.lastName = credential.fullName?.familyName ?? ""
                                self.userID = credential.user
                                self.isLoggedIn = true
                            }
                        case .failure(let error):
                            print(error)
                            alertMessage = "Sign in failed."
                            showingAlert = true
                        }
                    }
                    .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                    .frame(width: 280, height: 45)
                    .shadow(radius: 5)
                    .padding()
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Sign In"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    Spacer()
                }
                else{
                    //signed in
                    TabBar()
                }
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
//        // Show TabBar view upon successful login
//        .fullScreenCover(isPresented: $isLoggedIn) {
//            TabBar()
        }
    }


#Preview {
    LoginView()
}
