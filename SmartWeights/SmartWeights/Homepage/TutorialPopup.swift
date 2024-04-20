//
//  TutorialPopup.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/20/24.
//

import SwiftUI

struct TutorialPopup: View {
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
            VStack(spacing: 25) {
                Image(systemName: "trophy")
                    .foregroundStyle(.black)
                
                Text("Congratulations")
                    .font(.title)
                    .foregroundStyle(.pink)
                
                Text("You've Successfully Done the Work")
                
                Button(action: {
                    show.toggle()
                }) {
                    Text("Back To Home")
                        .foregroundStyle(.white)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background(Color.purple)
                        .clipShape(Capsule())
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlurView())
            .cornerRadius(25)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.35))
    }
}

struct BlurView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
            
    }
}

#Preview {
    TutorialPopup(show: .constant(true))
}
