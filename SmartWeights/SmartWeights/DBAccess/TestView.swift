//
//  TestView.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/18/24.
//

import SwiftUI


// View
struct TestView: View {
    @ObservedObject var viewModel: PetViewModel

    var body: some View {
        VStack {
            Text("Health: \(viewModel.pet.health)")
            Text("Level: \(viewModel.pet.level)")
            Text("Total XP: \(viewModel.pet.totalXP)")
            Button(action: {
                viewModel.saveToCloudKit()
            }) {
                Text("Save to CloudKit")
            }
        }
    }
}

#Preview {
    TestView()
}
