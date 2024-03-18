//
//  TestViewModel.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/18/24.
//

import Foundation
// ViewModel
class TestViewModel: ObservableObject {
    @Published var pet: Pet

    init(pet: Pet) {
        self.pet = pet
    }

    func saveToCloudKit() {
        CKContainer.default().accountStatus { (accountStatus, error) in
            if accountStatus == .available {
                let record = self.pet.record
                let privateDB = CKContainer.default().privateCloudDatabase
                privateDB.save(record) { (record, error) in
                    if let error = error {
                        print("Error saving record: \(error.localizedDescription)")
                    } else {
                        print("Successfully saved record.")
                    }
                }
            } else {
                print("No iCloud account is configured. Please sign in to save this pet.")
            }
        }
    }
}
