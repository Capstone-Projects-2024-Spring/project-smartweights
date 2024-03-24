import CloudKit
import os

final class CloudKitService {
    private static let logger = Logger(
        subsystem: "iCloud.SmartWeights",
        category: String(describing: CloudKitService.self)
    )

    func checkAccountStatus() async throws -> CKAccountStatus {
//         try await CKContainer.default().accountStatus()
        return .available
    }
    
}

@MainActor final class OnboardingViewModel: ObservableObject {
    private static let logger = Logger(
        subsystem: "iCloud.SmartWeights",
        category: String(describing: OnboardingViewModel.self)
    )

    @Published private(set) var accountStatus: CKAccountStatus = .couldNotDetermine

    private let cloudKitService = CloudKitService()

    func fetchAccountStatus() async {
        do {
            accountStatus = try await cloudKitService.checkAccountStatus()
        } catch {
            Self.logger.error("\(error.localizedDescription, privacy: .public)")
        }
    }
}
extension CloudKitService {
    func save(_ record: CKRecord) async throws {
        try await CKContainer.default().privateCloudDatabase.save(record)
    }
}
