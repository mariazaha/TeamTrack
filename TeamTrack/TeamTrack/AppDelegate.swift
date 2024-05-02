//
//  AppDelegate.swift
//  TeamTrack
//
//  Created by Maria Zaha on 01.05.2024.
//

import UIKit
import CoreData
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController(tabs: tabs())
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func tabs() -> Tabs {
        let homeView = HomeView()
        let profileView = ProfileView()
        
        let homeTabBarItem = UITabBarItem(
            title: "Home",
            image: IconService.homeOutline(),
            selectedImage: IconService.homeFilled()
        )
        
        let profileTabBarItem = UITabBarItem(
            title: "Profile",
            image: IconService.profileOutline(),
            selectedImage: IconService.profileFilled()
        )
        
        homeView.tabBarItem = homeTabBarItem
        profileView.tabBarItem = profileTabBarItem
        
        let profileNavigationController = UINavigationController(rootViewController: profileView)
        let homeNavigationController = UINavigationController(rootViewController: homeView)
        
        return Tabs(
            home: homeNavigationController,
            profile: profileNavigationController
        )
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TeamTrack")
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

