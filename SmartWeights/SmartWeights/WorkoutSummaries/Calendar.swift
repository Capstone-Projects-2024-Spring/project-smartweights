//
//  Calendar.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI

struct CalendarView: View {
    @StateObject var viewModel: OverallProgressViewModel
    
    
    
    var body: some View {
        HStack {
            Text("Date") // Title
                .font(.headline)
            DatePicker("WorkoutDatePicker", selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
                .labelsHidden() // Hide the DatePicker label
                .onChange(of: viewModel.date) {
                    viewModel.updateShortDate()
                   
                    
                }
            
           
        }
        
        
    }
}


#Preview {
    CalendarView(viewModel:OverallProgressViewModel())
}

