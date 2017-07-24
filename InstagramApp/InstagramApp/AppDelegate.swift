//
//  AppDelegate.swift
//  InstagramApp
//
//  Created by macosx on 14.06.17.
//  Copyright © 2017 macosx. All rights reserved.
//

import UIKit
import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // facebook SDK init.
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    // MARK: - User Opened App
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp() // Log current user session
    }
    
    // MARK: - Handle OpenURL
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                     open: url,
                                                                     sourceApplication: sourceApplication,
                                                                     annotation: annotation)
    }
  


}







