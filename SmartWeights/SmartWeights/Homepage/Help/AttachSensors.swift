//
//  AttachSensors.swift
//  SmartWeights
//
//  Created by Tu Ha on 4/23/24.
//

import SwiftUI
//instructions on how to attach the sensors on the dumbbell and the elbow sleeve
struct AttachSensors: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Attach Sensors")
                    .font(.title)
                
                Text("Required:")
                    .font(.headline)
                
                Text("• SmartWeight Sensors (Elbow and Dumbbell)")
                Text("• Elbow/arm sleeve with velcro")
                Text("• Dumbbell with velcro")
                
                
                Text("Instructions:")
                    .font(.headline)
                
                Text("1. Attach the dumbbell sensor to the dumbbell with the charging port facing up. Having the sensor attached in a different orientation will give inaccurate data")
                
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
    AttachSensors()
}
