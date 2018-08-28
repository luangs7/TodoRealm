//
//  KeychainUtils.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 12/05/17.
//  Copyright © 2017 55Apps. All rights reserved.
//
//  Reference
//  Addapted from Sazzad Hissain Khan:
//  http://stackoverflow.com/questions/37539997/save-and-load-from-keychain-swift

import Foundation
import Security


public class KeychainUtils: NSObject {
    
    /**
     *  User defined keys for new entry
     *  Note: add new keys for new secure item and use them in load and save methods
     */
    
    static private let passwordKey = "KeyForPassword"
    static private let userAccountKey = "AuthenticatedUser"
    static private let fidKey = "FacebookID"
    static private let accessGroupKey = "SecuritySerivice"
    
    // Arguments for the keychain queries
    static private let kSecClassValue = NSString(format: kSecClass)
    static private let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
    static private let kSecValueDataValue = NSString(format: kSecValueData)
    static private let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
    static private let kSecAttrServiceValue = NSString(format: kSecAttrService)
    static private let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
    static private let kSecReturnDataValue = NSString(format: kSecReturnData)
    static private let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

    /**
     *  Perform Save querie.
     */
    /** save passward */
    static func savePassword(_ password: String) {
        self.save(service: passwordKey as NSString, data: password as NSString)
    }
    
    /** save user account */
    static func saveUserAccount(_ email: String) {
        self.save(service: userAccountKey as NSString, data: email as NSString)
    }
    
    /** save user fid */
    static func saveFacebookID(_ fid: String) {
        self.save(service: fidKey as NSString , data: fid as NSString)
    }
    
    /**
     *  Perform Load querie.
     */
    /** load password*/
    static func loadPassword() -> String? {
        return self.load(service: passwordKey as NSString) as String?
    }
    
    /** load password*/
    static func loadUserAccount() -> String? {
        return self.load(service: userAccountKey as NSString) as String?
    }
    
    /** load fid */
    static func loadFID() -> String? {
        return self.load(service: fidKey as NSString) as String?
    }
    
    
    /**
     * Internal methods for querying the keychain.
     */
    
    static private func save(service: NSString, data: NSString) {
        let dataFromString: NSData = data.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccountKey, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add the new keychain item
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    static private func load(service: NSString) -> NSString? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccountKey, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: NSString? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? NSData {
                contentsOfKeychain = NSString(data: retrievedData as Data, encoding: String.Encoding.utf8.rawValue)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
}
