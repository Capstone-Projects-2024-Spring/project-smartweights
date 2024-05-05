//
//  RechargeSensors.swift
//  SmartWeights
//
//  Created by Tu Ha on 4/19/24.
//

import SwiftUI
///Instructions on how to recharge the sensors
struct RechargeSensors: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Recharge Sensors")
                    .font(.title)
                    .bold()
                    .foregroundColor(.africanViolet)
                
                Text("Required:")
                    .font(.headline)
                
                Text("• SmartWeight Sensors (Elbow and Dumbbell)")
                
                Text("• Micro-USB cable")
                
                Text("Instructions:")
                    .font(.headline)
                
                Text("1. Plug the micro-USB cable into the micro-USB port on the sensor.")
                
                Text("2. Plug the other end of the micro-USB cable into a charging block.")
                
                Image("chargingPort")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text("3. A red light will appear to indicate the sensor is charging.")
                
                Image("charging")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text("4. The light will turn off when the sensor is fully charged.")
            }
            .padding()
        }
        
        
        
    
    }
}

#Preview {
    RechargeSensors()
}
