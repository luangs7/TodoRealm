//
//  Conversa.swift
//  TodoRealm
//
//  Created by Retina on 8/29/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit
import RealmSwift

class Conversa: Object {
    
    @objc dynamic var message = ""
    @objc dynamic var date = ""
    @objc dynamic var idOwner = 0
    @objc dynamic var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
