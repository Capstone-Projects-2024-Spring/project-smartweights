//
//  TutorialPopup.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/20/24.
//

import SwiftUI

struct TutorialPopup: View {
    
    @Binding var show: Bool
    @AppStorage("ShowTutorial") var showTutorial = true
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
            VStack(spacing: 25) {
                
                Text("Welcome to SmartWeights!")
                    .font(.title2)
                    .foregroundStyle(.black)
                
                Text("Tap on the video to get started")
                    .font(.subheadline)
                    .padding(.vertical, -20)
                    .opacity(0.5)
                
                VideoView(videoId: "K9E32Z8ZQDU")
                    .frame(width: 200, height: 200)
                
                Button(action: {
                    show.toggle()
                    showTutorial = false
                }) {
                    Text("Get Started!")
                        .foregroundStyle(.white)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background(Color.africanViolet)
                        .clipShape(Capsule())
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(.white)
            .cornerRadius(25)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.35))
    }
}

#Preview {
    TutorialPopup(show: .constant(true))
}
