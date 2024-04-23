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
                    .bold()
                    .foregroundColor(.africanViolet)
                
                Text("Required:")
                    .font(.headline)
                
                Text("• SmartWeight Sensors (Elbow and Dumbbell)")
                HStack{
                    Image("elbowSensor")
                        .resizable()
                        .frame(width: 150, height: 200)
                    Image("dumbbellSensor")
                        .resizable()
                        .frame(width: 150, height: 200)
                }
                Text("      *The dumbbell sensor will have a hole in the side of the case")
                    .font(.caption)
                Text("• Elbow/arm sleeve with velcro")
                Image("elbowVelcro")
                    .resizable()
                    .frame(width: 150, height: 200)
                Text("• Dumbbell with velcro")
                Image("dumbbellVelcro")
                    .resizable()
                    .frame(width: 150, height: 200)
                
                
                Text("Instructions:")
                    .font(.headline)
                
                Text("1. Attach the dumbbell sensor to the dumbbell with the charging port facing up.")
                Image("dumbbellPlacement")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 300, height: 300)
                
                Text("*Having the sensor attached in a different orientation will give inaccurate data")
                    .font(.caption)
                
                Text("2. Put on the arm/elbow sleeve and make sure the velcro is on the backside of the arm. Attach the elbow sensor with the charging port facing left or right.")
                
                HStack{
                    Image("elbow")
                        .resizable()
                        .frame(width: 150, height: 200)
                    Image("sensorOnElbow")
                        .resizable()
                        .frame(width: 150, height: 200)
                }
                Text("*Having the sensor attached in a different orientation will give inaccurate data")
                    .font(.caption)
                
                Text("3. Turn on the sensors with the button under the charging port. A green light will indicate that the sensor is on.")
                
                Image("dumbbellSensorOn")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                Text("4. Check that the sensors are connected on the Workout page. On the top right of the page there are two icons to showing the connections of the sensors. Red means not connected, green means connected.")
                Image("connection")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            }
            .padding()
        }
        
        
        
    
    }

}

#Preview {
    AttachSensors()
}
