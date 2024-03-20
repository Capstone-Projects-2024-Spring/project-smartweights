////
////  TestUI.swift
////  SmartWeights
////
////  Created by Daniel Eap on 3/15/24.
////
//
//import SwiftUI
//
//struct OnboardingView: View {
//    @StateObject private var petViewModel = PetViewModel()
//    @StateObject private var viewModel = OnboardingViewModel()
//    @State private var accountStatusAlertShown = false
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        Button("startUsingApp") {
//            if viewModel.accountStatus != .available {
//                accountStatusAlertShown = true
//            } else {
//                // Show popup with user credentials
//                Task {
//                    await petViewModel.save()
//                    dismiss()
//                }
//                
//            }
//        }
//        .alert("iCloudAccountDisabled", isPresented: $accountStatusAlertShown) {
//            Button("cancel", role: .cancel, action: {})
//        }
//        .task {
//            await viewModel.fetchAccountStatus()
//        }
//        
//        
//    }
//}
//
//#Preview {
//    OnboardingView()
//}

