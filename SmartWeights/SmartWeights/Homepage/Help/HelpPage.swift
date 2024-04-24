//
//  HelpPage.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/24/24.
//

import SwiftUI

struct HelpPage: View {
    var body: some View {
        
        var numSections = 9
        
        NavigationSplitView {
            List {
                NavigationLink {
                    Text("Hello World")
                } label: {
                    Text("Login")
                }
            }
            .navigationTitle("Help")

            
//            List(0..<numSections, id: \.self) { index in
//                NavigationLink("Row \(index)", value: index)
//            }
//            .navigationDestination(for: Int.self) {
//                Text("Selected row \($0)")
//            }
//            .navigationTitle("Split View")
        } detail: {
            Text("Please select a row")
        }
        
    }
}

#Preview {
    HelpPage()
}
