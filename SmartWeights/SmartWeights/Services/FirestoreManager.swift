//
//  FirestoreManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 2/21/24.
//

import FirebaseFirestore


final class FirestoreManager {
    static let shared = FirestoreManager()
    
    private let firestore = Firestore.firestore()
    
    private init() {}
    
    func getFirestore() -> Firestore {
        return firestore
    }
    func fetchMultipleDocuments(collection: String, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
            let collectionRef = firestore.collection(collection)
            collectionRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else {
                    var documents: [[String: Any]] = []
                    for document in querySnapshot!.documents {
                        documents.append(document.data())
                    }
                    completion(documents, nil)
                }
            }
        }
}

