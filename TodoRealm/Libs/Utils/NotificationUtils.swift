//
//  NotificationUtils.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 19/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

class NotificationUtils {
    
    //MARK: - Register
    static open func registerNotification(_ notificationName: String, withSelector selector: Selector, fromObserver observer: AnyObject) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(notificationName), object: nil)    
    }
    
    //MARK: - Unregister
    static open func unregisterNotification(_ notificationName: String, fromObserver observer: AnyObject) {
        NotificationCenter.default.removeObserver(observer, name: Notification.Name(notificationName), object: nil)
    }
    
    static open func unregisterAllNotificationsFromObserver(_ observer: AnyObject) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    //MARK: - Post
    static open func postNotification(_ notificationName: String, withObject object: AnyObject? = nil) {
        NotificationCenter.default.post(name: Notification.Name(notificationName), object: object)
    }
    
    static open func postNotification(_ notification: Notification) {
        NotificationCenter.default.post(notification)
    }
    
    // MARK: - Notifications
    static open func cancellAllNotifications() {
        //XXX:  
//        UIApplication.shared.cancelAllLocalNotifications()
    }
}

