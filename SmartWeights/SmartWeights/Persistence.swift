//
//  Persistence.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/12/24.
//

import CoreData

/// Defines a PersistenceController struct to manage the Core Data stack for the application.
struct PersistenceController {
    
    /// Provides a shared instance of PersistenceController for use throughout the app.
    static let shared = PersistenceController()

    /// Creates a preview instance of PersistenceController for development and testing purposes.
    /// This in-memory version is populated with sample data to facilitate UI development and testing without affecting the actual database.
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Populates the in-memory database with 10 new items, each with a current timestamp.
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        // Attempts to save the context, handling any errors that occur.
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    /// The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    let container: NSPersistentCloudKitContainer
    
    static let sharedManagedObjectModel: NSManagedObjectModel = {
            let modelURL = Bundle.main.url(forResource: "SmartWeights", withExtension: "momd")!
            return NSManagedObjectModel(contentsOf: modelURL)!
        }()

    /// Initializes a new PersistenceController.
    /// The inMemory flag determines whether the persistent store is stored in memory or on disk.
    init(inMemory: Bool = false) {
            container = NSPersistentCloudKitContainer(name: "SmartWeights", managedObjectModel: PersistenceController.sharedManagedObjectModel)
            
            if inMemory {
                let description = NSPersistentStoreDescription()
                description.type = NSInMemoryStoreType
                container.persistentStoreDescriptions = [description]
            }
        
        // Loads the persistent stores and handles any errors.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        if inMemory {
//            If in-memory store, disable cloudkit integration
            container.viewContext.automaticallyMergesChangesFromParent = false
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            container.persistentStoreDescriptions.forEach({ $0.setOption(false as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)})
        }
        
        // Ensures that the viewContext automatically merges changes saved in any context that is a child of the main context.
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension PersistenceController {
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
