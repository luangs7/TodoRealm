//
//  BaseAppDelegate.swift
//  fex-ios
//
//  Created by Luan Silva on 23/06/17.
//  Copyright © 2017 fexsaude. All rights reserved.
//

import UIKit

class BaseAppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Variables
    open var window: UIWindow?
    var stackCoontrollValue = 0
    var application: UIApplication!
    var baseRootNavigation: UINavigationController!
    
    //MARK: - Application
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        return true
    }
    
    /**
     Cria um `UINavigationController` com o `UIViewController` inicial passado e associa a uma `UIWindow`.
     - important: Este método deve ser chamado no didFinishLaunchingWithOptions.
     - returns: Uma `UIWindow` configurada para este app.
     */
    
    
//
//    open func sendToLogin()-> UIWindow{
//        UIApplication.shared.statusBarView()?.backgroundColor = StatusBarUtils.hexStringToUIColor(hex: "#4690D5")
//
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = ApresentationViewController(nibName: "ApresentationViewController", bundle: nil)
//        let rootNavigation = UINavigationController(rootViewController: vc)
//        window.rootViewController = rootNavigation
//        window.clipsToBounds = true
//
//        window.makeKeyAndVisible()
//        return window
//    }
    
    open func createWindow()-> UIWindow{
        UIApplication.shared.statusBarView()?.backgroundColor = StatusBarUtils.hexStringToUIColor(hex: "#1f272f").withAlphaComponent(0.5)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MainViewController(nibName: "MainViewController", bundle: nil)
        let rootNavigation = UINavigationController(rootViewController: vc)
        window.rootViewController = rootNavigation
        window.clipsToBounds = true
        
        window.makeKeyAndVisible()
        return window
        
    }
}

//Singleton
extension BaseAppDelegate {
    
    //MARK: - Singleton
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func getStackValue() -> Int {
        return stackCoontrollValue
    }
    
    //MARK: - Setters
    func setSatckValue(stackValue value: Int) {
        self.stackCoontrollValue = value
    }
    
    //MARK: - Getters
    func getApplication() -> UIApplication {
        return application
    }
    
    func getRootNavigation() -> UINavigationController {
        return baseRootNavigation
    }
}
