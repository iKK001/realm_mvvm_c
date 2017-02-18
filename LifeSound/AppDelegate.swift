//
//  AppDelegate.swift
//  LifeSound
//
//  Created by Stephan Korner on 15.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?
	var appCoordinator: AppCoordinator!
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// Override point for customization after application launch.
		
		// set your new realm-schemaVersion (set below in config)
		// Hint: only set this myNewSchemaVersion if your realm-model has changed$
		// This way, you can overcome cumbersome migration...
		let myNewSchemaVersion: UInt64 = 1
		
		// determine the persisted current realm-schemaVersion of your installed App
		var currentSchemaVersion: UInt64 = 0
		do {
			currentSchemaVersion = try schemaVersionAtURL(Realm.Configuration.defaultConfiguration.fileURL!)
			// print("\(currentSchemaVersion)")
		}
		catch {
			// no realm detected... no problem for now...
		}
		// remove existing realm file if schemaVersion is not the newest (the one that is also set below)
		// also make sure the firstTimeLaunch-Flag is reset to false inside the UserDefaults
		if (currentSchemaVersion < myNewSchemaVersion) {
			do {
				try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
				UserDefaults.standard.set(false, forKey: AppConstants.FIRST_LAUNCH_KEY)
			} catch {
				fatalError("couldn't remove at path")
			}
		}
		
		// Tell Realm to use this new configuration object for the default Realm
		let config = Realm.Configuration(
			// Set the new schema version. This must be greater than the previously used
			// version (if you've never set a schema version before, the version is 0).
			schemaVersion: myNewSchemaVersion //,
			// eventually set a migration block here.... (don't forget the "," Komma right above here)
			// migrationBlock: { migration, oldSchemaVersion in
			//     // We haven’t migrated anything yet, so oldSchemaVersion == 0
			//     if (oldSchemaVersion < myNewSchemaVersion) {
			//  	  // Nothing to do!
			//  	  // Realm will automatically detect new properties and removed properties
			//  	  // And will update the schema on disk automatically
			//     }
			// }
		)
		// set the new configuration to your default-realm
		Realm.Configuration.defaultConfiguration = config
		
		// since no Main.storyboard, you need to define your first Window
		
		window = UIWindow()
		appCoordinator = AppCoordinator(window: window!)
		appCoordinator.start()
		window?.makeKeyAndVisible()
		
		return true
	}
}

