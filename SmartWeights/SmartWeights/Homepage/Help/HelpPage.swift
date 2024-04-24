//
//  HelpPage.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/24/24.
//

import SwiftUI

struct HelpPage: View {
    var body: some View {
        
        NavigationStack {
            List {
                
                // Login
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Login")
                            .font(.title)
                            .padding(.bottom    )
                        Text("When you first open the application, you will be greeted with our sign in page. Once you sign in using your apple account, you will automatically be signed in the app in the future.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Login")
                }
                
                // Home page
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Homepage")
                            .font(.title)
                            .padding(.bottom)
                        Text("After login, you will be greeted with the home page. The home page contains a direct path to start a workout and other shortcuts for your convenience. This page also contains educational videos to improve your SmartWeights experience. This tutorial can be viewed anytime from this page.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Homepage")
                }
                
            }
            .navigationTitle("Help")

            
//            List(0..<numSections, id: \.self) { index in
//                NavigationLink("Row \(index)", value: index)
//            }
//            .navigationDestination(for: Int.self) {
//                Text("Selected row \($0)")
//            }
//            .navigationTitle("Split View")
        }
        
    }
}

#Preview {
    HelpPage()
}
