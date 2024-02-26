//
//  WorkoutGraph.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI
import Charts

struct DataPoints: Identifiable {
    
    var id = UUID().uuidString
    var date: String
    var form: Int
}


struct WorkoutGraph: View {
    
    var data = [
        DataPoints(date: "2/2/24", form: 90),
        DataPoints(date: "2/3/24", form: 98),
        DataPoints(date: "2/4/24", form: 90),
        DataPoints(date: "2/5/24", form: 98),
        DataPoints(date: "2/6/24", form: 56),
        DataPoints(date: "2/7/24", form: 88),
        DataPoints(date: "2/10/24", form: 90),
        DataPoints(date: "2/22/24", form: 90),
        DataPoints(date: "3/5/24", form: 98),
        DataPoints(date: "3/6/24", form: 56),
        DataPoints(date: "3/7/24", form: 88),
        DataPoints(date: "3/10/24", form: 90),
        DataPoints(date: "4/10/24", form: 90),
        DataPoints(date: "4/22/24", form: 90),
        DataPoints(date: "5/5/24", form: 98),
        DataPoints(date: "5/6/24", form: 56),
        DataPoints(date: "5/7/24", form: 88),
        DataPoints(date: "5/10/24", form: 90)
        
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
            
            
            
            
        }
        
        
        
    }
    
    
    
}

#Preview {
    WorkoutGraph()
}



