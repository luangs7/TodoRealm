//
//  NSObjectExtension.swift
//
//  Created by Livetouch
//  Updated by Luan Silva
//

import Foundation
import ObjectiveC

private var queueAssociationKey: UInt8 = 0

public extension NSObject {
    
    //MARK: - Queue
    fileprivate(set) public var queue: OperationQueue? {
        get {
            return objc_getAssociatedObject(self, &queueAssociationKey) as? OperationQueue
        }
        set(newValue) {
            objc_setAssociatedObject(self, &queueAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var maxConcurrentOperationCount : Int {
        get {
            assert(queue != nil, "Você deve implementar o método setupQueue: antes de obter o maxConcurrentOperationCount")
            
            return queue!.maxConcurrentOperationCount
        }
        set {
            assert(queue != nil, "Você deve implementar o método setupQueue: antes de mudar o maxConcurrentOperationCount")
            
            queue?.maxConcurrentOperationCount = newValue
        }
    }
    
    public final func setupQueue() {
        self.queue = OperationQueue()
        self.queue?.maxConcurrentOperationCount = 5
    }
    
    
    
    //MARK: - Cancel Tasks
    public func cancelTasks() {
        queue?.cancelAllOperations()
    }
    
    public func cancelTask(_ operation: BlockOperation?) {
        if let operation = operation {
            operation.cancel()
        }
    }
    
    //MARK: - Notifications
    public func registerNotification(_ notificationName: String, withSelector selector: Selector) {
        NotificationUtils.registerNotification(notificationName, withSelector: selector, fromObserver: self)
    }
    
    public func unregisterNotification(_ notificationName: String) {
        NotificationUtils.unregisterNotification(notificationName, fromObserver: self)
    }
    
    public func unregisterAllNotifications() {
        NotificationUtils.unregisterAllNotificationsFromObserver(self)
    }
    
    public func postNotification(_ notificationName: String, withObject object: AnyObject? = nil) {
        NotificationUtils.postNotification(notificationName, withObject: object)
    }
    
    public func postNotification(_ notification: Notification) {
        NotificationUtils.postNotification(notification)
    }
    
    
    //MARK: - Thread
    //TODO: Criar mais metodos de opções async
    public func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    public func sleep(_ time: TimeInterval) {
        Thread.sleep(forTimeInterval: time)
    }
    
    public func dispatchBackground(_ _block: @escaping ()->()) {
        let queue = DispatchQueue.global()
        queue.async(execute: _block)
    }
    
    public func dispatchMain(_ _block: @escaping ()->()) {
        let queue = DispatchQueue.main
        queue.async(execute: _block)
    }
    
}

