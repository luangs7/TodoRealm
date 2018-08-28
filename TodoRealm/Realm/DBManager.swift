//
//  DBManager.swift
//  TodoRealm
//
//  Created by Retina on 8/28/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    private var   database:Realm
    static let   sharedInstance = DBManager()
    private init() {
        database = try! Realm()
    }
    func getDataFromDB() ->   Results<Item> {
        let results: Results<Item> =   database.objects(Item.self)
        return results
    }
    func addData(object: Item)   {
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
    func deleteFromDb(object: Item)   {
        try!   database.write {
            database.delete(object)
        }
    }
}
