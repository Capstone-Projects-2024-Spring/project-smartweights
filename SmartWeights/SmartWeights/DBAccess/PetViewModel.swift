//
//  PetViewModel.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/15/24.
//

import Foundation
import CloudKit
import os

@MainActor final class PetViewModel: ObservableObject {
    private static let logger = Logger(
        subsystem: "iCloud.SmartWeights",
        category: String(describing: PetViewModel.self)
    )

    @Published var pet: Pet = .init(
        health: 100,
        level: 2,
        totalXP: 200
    )
    @Published private(set) var isSaving = false

    private let cloudKitService = CloudKitService()

    func save() async {
        isSaving = true

        do {
            try await cloudKitService.save(pet.record)
        } catch {
            Self.logger.error("\(error.localizedDescription, privacy: .public)")
        }

        isSaving = false
    }
}
