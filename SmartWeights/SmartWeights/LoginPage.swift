//
//  LoginView.swift
//  SmartWeights
//
//  Created by par chea on 2/14/24.
//

import SwiftUI
import AuthenticationServices // Import necessary for Apple Sign In

struct LoginView: View {
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var navigateToNextPage = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text("Smart Weight")
                        .font(.system(size: 55))
                        .foregroundStyle(.white)
                        .italic()
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 20)
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 450, height: 350)
                        .cornerRadius(50)
                        .shadow(radius: 10)
                        .padding(.bottom, 20)
                    
                    // Custom Sign In Button - Replace this with SignInWithAppleButton for real sign-in
                    Button(action: {
                        // Here's where you'd trigger the real Apple ID sign-in process
                        
                        /*
                         SignInWithAppleButton(.signIn, onRequest: { request in
                            // Configure the request here
                            request.requestedScopes = [.fullName, .email]
                        }, onCompletion: { result in
                            switch result {
                            case .success(let authResults):
                                // Handle successful authentication here
                                self.alertMessage = "Sign in successful!"
                                self.navigateToNextPage = true
                            case .failure(let error):
                                // Handle authentication error here
                                self.alertMessage = "Sign in failed: \(error.localizedDescription)"
                                self.showingAlert = true
                            }
                        })
                         .signInWithAppleButtonStyle(.black) // Adjust the style
                         .frame(width: 280, height: 45)
                         .shadow(radius: 5) // Add shadow
                         .padding()
                         .alert(isPresented: $showingAlert) {
                             Alert(title: Text("Sign In"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                         */
                        
                        // Simulate navigation for demonstration purposes
                        self.navigateToNextPage = true
                    }) {
                        HStack {
                            Image(systemName: "applelogo")
                                .foregroundColor(.white)
                            Text("Sign In with Apple")
                                .foregroundColor(.white)
                        }
                        .frame(width: 280, height: 45)
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .padding()
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Sign In"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: NavController().navigationBarBackButtonHidden(true), isActive: $navigateToNextPage) {
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
