//
//  Homepage.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//
 
import SwiftUI

struct Homepage: View {

    var body: some View {
        Text("Homepage")
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Expand text container for background visibility
            .background(Color.black) // Apply color as background
            .edgesIgnoringSafeArea(.top) // Ignore the top safe area
            .edgesIgnoringSafeArea(.bottom) // Ignore the bottom safe area
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}



