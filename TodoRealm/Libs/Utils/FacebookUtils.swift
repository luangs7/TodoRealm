//
//  FacebookUtils.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 14/03/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


protocol FacebookDelegate {
    func facebookLoginError()
    func facebookLoginCancelled()
    func facebookLoginSuccess()
}

public enum FBPermissions: String {
    case publicProfile = "public_profile",
    userFriends = "user_friends",
    userBirthday = "user_birthday",
    email = "email"
}

public enum FBUserDetails: String {
    case id = "id",
    email = "email",
    firstName = "first_name",
    lastName = "last_name",
    verified = "verified",
    gender = "gender",
    link = "link",
    locale = "locale",
    name = "name",
    middleName = "middle_name",
    timezone = "timezone",
    updatedAt = "updated_time",
    userFriends = "user_friends",
    userBirthday = "user_birthday"
}

class FacebookUtils {
    
    //MARK - Methods
    static func activateApp() {
        FBSDKAppEvents.activateApp()
    }
    
    static func isFBLogged() -> Bool {
        return FBSDKAccessToken.current() != nil ? true : false
    }
    
    //AppDelegate
    static func didFinishLaunchWith(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    static func openSourceApplication(application: UIApplication, url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    static private func getPermissions(_ fbPermissions: [FBPermissions]) -> [String] {
        var permissionList: [String] = []
        for permission in fbPermissions {
            permissionList.append(permission.rawValue)
        }
        return permissionList
    }
    
    
    static func performFBLogin(fbPermissions: [FBPermissions], forVC viewController: UIViewController, completionWithError: @escaping () -> Void, completionWithCancel: @escaping () -> Void, completionWithToken: @escaping (_ token: String) -> Void) {
        
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        
        let loginManager = FBSDKLoginManager()
        let permissions: [String] = getPermissions(fbPermissions)
        loginManager.loginBehavior = .web
        
        if !NetworkUtils.isAvailable() {
            ServiceException.withStatusCode(NSURLErrorNotConnectedToInternet)
            return completionWithError()
        }
        
        loginManager.logIn(withReadPermissions: permissions, from: viewController) { (result, error) in
            if error != nil {
                ServiceException.withType(.facebookLoginError)
                debugPrint("FB_ERROR -> ", error.debugDescription)
                return completionWithError()
            }
            
            guard let result = result else {
                ServiceException.withType(.facebookLoginError)
                print("FB_ERROR -> RESULT NIL")
                return completionWithError()
            }
            
            if result.isCancelled {
                return completionWithCancel()
            }
            
            for permission in permissions {
                if !result.grantedPermissions.contains(permission) {
                    print("FB_ERROR PERMISSÃO NÃO GARANTIDA ->", permission)
                    return completionWithError()
                }
            }
            
            if let token = result.token {
                let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name, last_name, middle_name, email, picture.type(small)"])
                let connection = FBSDKGraphRequestConnection()
                connection.add(graphRequest, completionHandler: { (connection, result, error) in
                    if let error = error {
                        ServiceException.withType(.facebookLoginError)
                        debugPrint("FB_ERROR -> ", error.localizedDescription)
                    }
                    completionWithToken(token.tokenString)
                })
                connection.start()
            }
        }
    }
    
    static func performLogout() {
        guard let _ = FBSDKAccessToken.current() else {
            return
        }
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
}
