//
//  AppDelegate.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/11/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import Crashlytics
import Fabric

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigateFrom = String()
    var segmentType = String()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        navigateFrom=""
        Switcher.updateRootVC()
        FirebaseApp.configure()
        // Fabric.with(Crashlytics.self)
        Fabric.with([Crashlytics.self])
        
        Fabric.sharedSDK().debug = true
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
      self.window?.endEditing(true)
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
     
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
      
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        self.saveContext()
    }


    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SpectraNet")
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
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

