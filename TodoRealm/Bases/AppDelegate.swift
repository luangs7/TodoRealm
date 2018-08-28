//
//  AppDelegate.swift
//  ClickSrvicesApp
//
//  Created by Luan Silva on 07/11/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: BaseAppDelegate{
    internal var session = Session.shared
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.application = application
        
        UIApplication.shared.statusBarStyle = .lightContent
        self.window = self.createWindow()

       
        
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {}
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {}
    
}

