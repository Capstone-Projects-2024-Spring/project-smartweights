//
//  WorkoutGraph.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI
import Charts

struct WorkoutGraph: View {
    
    var data = [
        DataPoints(date: "2/2/24", form: 90),
        DataPoints(date: "2/3/24", form: 98),
        DataPoints(date: "2/4/24", form: 90),
        DataPoints(date: "2/5/24", form: 98),
        DataPoints(date: "2/6/24", form: 56),
        DataPoints(date: "2/7/24", form: 88),
        DataPoints(date: "2/10/24", form: 90)
        
    ]
        
        var body: some View{
           
                    
                
                Chart{
                    ForEach(data){ d in
                        LineMark(x: PlottableValue.value("date", d.date),
                                 y: .value("form", d.form))
                        
                    }
                    
                    
                }
                //.chartYAxisLabel(position: .trailing, alignment: .center)
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
            

        }
        
        
    
}

#Preview {
        WorkoutGraph()
    }




