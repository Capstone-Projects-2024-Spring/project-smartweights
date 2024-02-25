//
//  Calendar.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI


//a basic calendar
//will need to change to add a view model 

///structure to display a calendar
///selectedDate: the date selected by the user



struct Calendar: View {
    @State public var selectedDate = Date()
    var body: some View {
        HStack {
            Text("Date") // Title
                .font(.headline)
            DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                .labelsHidden() // Hide the DatePicker label
        }
    }
}

#Preview {
    Calendar()
}

