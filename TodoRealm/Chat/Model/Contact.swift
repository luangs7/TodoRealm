//
//  Contact.swift
//  TodoRealm
//
//  Created by Retina on 8/29/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit
import RealmSwift

class Contact: Object {

    @objc dynamic var id:Int = 0
    @objc dynamic var picture = ""
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    let conversation = List<Conversa>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}
