//
//  TestDB.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/19/24.
//

import Foundation
import SwiftUI
import CloudKit

class TestDBViewModel : ObservableObject{
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    @Published var permissionStatus: Bool = false
    @Published var text: String = ""
    init(){
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    private func getiCloudStatus(){
        CKContainer.default().accountStatus{[weak self] returnedStatus, returnedError in
            DispatchQueue.main.async{
                switch returnedStatus{
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.localizedDescription
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.localizedDescription
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.localizedDescription
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.localizedDescription
                }
            }
            
        }
    }
    enum CloudKitError: LocalizedError{
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    func requestPermission(){
        CKContainer.default().requestApplicationPermission([.userDiscoverability]){
            [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async{
                if returnedStatus == .granted{
                    self?.permissionStatus = true
                }
            }
        }
    }
    func fetchiCloudUserRecordID(){
        CKContainer.default().fetchUserRecordID{ [weak self] returnedID, returnedError in
            if let id = returnedID{
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    func discoveriCloudUser(id: CKRecord.ID){
        CKContainer.default().discoverUserIdentity(withUserRecordID: id){ [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async{
                if let name = returnedIdentity?.nameComponents?.givenName{
                    self?.userName = name
                }
            }
        }
    }
    func addItem(name: String){
        let newPet = CKRecord(recordType: "Pet")
        newPet["pet"] = name
        saveItem(record: newPet)
    }
    private func saveItem(record: CKRecord){
        CKContainer.default().privateCloudDatabase.save(record){[weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            DispatchQueue.main.async{
                self?.text = ""
            }
        }
    }
}



struct TestDB : View {
    
    @StateObject private var vm = TestDBViewModel()
    @State private var itemName = ""
    var body : some View{
        Text("is signed in \(vm.isSignedInToiCloud.description.uppercased())")
        Text(vm.error)
        Text("Permission: \(vm.permissionStatus.description.uppercased())")
        Text("NAME: : \(vm.userName)")
        TextField("Name", text: $itemName)
        Button("Add Item") {
            
            Task{
                vm.addItem(name: itemName)
            }
        }
    }
}

struct TestDB_Previews : PreviewProvider{
    static var previews: some View{
        TestDB()
    }
}
