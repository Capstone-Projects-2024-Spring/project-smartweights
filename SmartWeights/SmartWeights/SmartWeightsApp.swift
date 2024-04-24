//
//  SmartWeightsApp.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/12/24.
//

import SwiftUI
import CoreData

// AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    lazy var persistentContainer: NSPersistentContainer = PersistenceController.shared.container
}

@main
struct SmartWeightsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
          LoginView()
               .environment(\.managedObjectContext, persistenceController.container.viewContext)
               .preferredColorScheme(.light)
//            testview()
        }
        
    }
}
