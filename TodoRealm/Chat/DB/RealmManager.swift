//
//  RealmManager.swift
//  TodoRealm
//
//  Created by Retina on 8/29/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager {
    private var   database:Realm
    static let   sharedInstance = RealmManager()
    private init() {
        database = try! Realm()
    }
    func getContacts() ->   Results<Contact> {
        let results: Results<Contact> =   database.objects(Contact.self).sorted(byKeyPath: "name")
        return results
    }
    
    func addContact(object: Contact)   {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    func deleteAllFromDatabase()  {
        try!   database.write {
            database.deleteAll()
        }
    }
    func deleteContactFromDb(object: Contact)   {
        try!   database.write {
            database.delete(object)
        }
    }
    
    
}

