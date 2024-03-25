//
//  VoiceView.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/24/24.
//

import SwiftUI

struct VoiceView: View {
    @StateObject var viewModel = VoiceRecognitionViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.startListening()
            }) {
                Text("Start Listening")
            }
            .disabled(viewModel.isListening)
        }
        
    }
}

#Preview {
    VoiceView()
}
