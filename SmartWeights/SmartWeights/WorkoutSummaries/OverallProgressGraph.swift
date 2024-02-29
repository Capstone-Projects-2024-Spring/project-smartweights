//
//  WorkoutGraph.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI
import Charts




struct FormDataPoints: Identifiable {
    
    var id = UUID().uuidString
    var date: String
    var form: Int
}


struct VelocityDataPoints: Identifiable {
    
    var id = UUID().uuidString
    var date: String
    var form: Int
}

struct WorkoutGraphForm: View {
    
    var data = [
        FormDataPoints(date: "2/2/24", form: 90),
        FormDataPoints(date: "2/3/24", form: 98),
        FormDataPoints(date: "2/4/24", form: 90),
        FormDataPoints(date: "2/5/24", form: 98),
        FormDataPoints(date: "2/6/24", form: 56),
        FormDataPoints(date: "2/7/24", form: 88),
        FormDataPoints(date: "2/10/24", form: 90),
        FormDataPoints(date: "2/22/24", form: 90),
        FormDataPoints(date: "3/5/24", form: 98),
        FormDataPoints(date: "3/6/24", form: 56),
        FormDataPoints(date: "3/7/24", form: 88),
        FormDataPoints(date: "3/10/24", form: 90),
        FormDataPoints(date: "4/10/24", form: 90),
        FormDataPoints(date: "4/22/24", form: 90),
        FormDataPoints(date: "5/5/24", form: 98),
        FormDataPoints(date: "5/6/24", form: 56),
        FormDataPoints(date: "5/7/24", form: 88),
        FormDataPoints(date: "5/10/24", form: 90)
        
    ]
    
    var body: some View{
        
        ZStack {
            
            Chart{
                ForEach(data){ d in
                    LineMark(x: PlottableValue.value("date", d.date),
                             y: .value("form", d.form))
                }
            }
            .chartXAxisLabel(position: .bottom, alignment: .center) {
                Text("date")
                    .bold()
            }
            .chartYAxisLabel(position: .leading, alignment: .center) {
                Text("Form  accuracy (%)")
                    .bold()
            }
            .padding()
            .frame(width: 350, height: 300)
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 6)
            .foregroundColor(.blue)
            .background(Color.gray)
        }
    }
}

struct WorkoutGraphVelocity: View {
    
    var data = [
        VelocityDataPoints(date: "2/2/24", form: 90),
        VelocityDataPoints(date: "2/3/24", form: 98),
        VelocityDataPoints(date: "2/4/24", form: 90),
        VelocityDataPoints(date: "2/5/24", form: 98),
        VelocityDataPoints(date: "2/6/24", form: 56),
        VelocityDataPoints(date: "2/7/24", form: 88),
        VelocityDataPoints(date: "2/10/24", form: 90),
        VelocityDataPoints(date: "2/22/24", form: 90),
        VelocityDataPoints(date: "3/5/24", form: 98),
        VelocityDataPoints(date: "3/6/24", form: 56),
        VelocityDataPoints(date: "3/7/24", form: 88),
        VelocityDataPoints(date: "3/10/24", form: 90),
        VelocityDataPoints(date: "4/10/24", form: 90),
        VelocityDataPoints(date: "4/22/24", form: 90),
        VelocityDataPoints(date: "5/5/24", form: 98),
        VelocityDataPoints(date: "5/6/24", form: 56),
        VelocityDataPoints(date: "5/7/24", form: 88),
        VelocityDataPoints(date: "5/10/24", form: 90)
        
    ]
    
    var body: some View{
        
        ZStack {
            
            Chart{
                ForEach(data){ d in
                    LineMark(x: PlottableValue.value("date", d.date),
                             y: .value("Velocity", d.form))
                }
            }
            
            .chartXAxisLabel(position: .bottom, alignment: .center) {
                Text("date")
                    .bold()
            }
            .chartYAxisLabel(position: .leading, alignment: .center) {
                Text("Velocity  accuracy (%)")
                    .bold()
                
            }
            
            .padding()
            .frame(width: 350, height: 300)
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 6)
            .foregroundColor(.blue)
            .background(Color.gray)
        }
    }
}


#Preview {
    WorkoutGraphForm()
}



