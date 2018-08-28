//
//  Item.swift
//  TodoRealm
//
//  Created by Retina on 8/28/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit
import RealmSwift

class Item: Object {

    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    var isFinished = false


    override static func primaryKey() -> String? {
        return "id"
    }

}

