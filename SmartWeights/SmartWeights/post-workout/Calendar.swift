//
//  Calendar.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI

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
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Calendar()
//    }
//}
