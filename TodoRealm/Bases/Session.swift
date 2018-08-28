//
//  Session.swift
//  ClickServicesApp
//
//  Created by Luan Silva on 16/11/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit
import CoreLocation

enum SessionType {
    case guest, user, professional
}

class Session {
    
    private let kToken = "TOKEN_KEY"
    private let userDefault = UserDefaults.standard
    //singleton
    static var shared = Session()
    private init() {}

}

