//
//  SmartWeightsApp.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/12/24.
//

import SwiftUI

@main
struct SmartWeightsApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            bluetoothView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
