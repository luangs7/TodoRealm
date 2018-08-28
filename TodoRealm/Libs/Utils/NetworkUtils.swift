//
//  NetworkUtils.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 27/04/17.
//  From Livetouch

import UIKit
import SystemConfiguration
import AudioToolbox

open class NetworkUtils: NSObject {
    
    static open func isAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    static open func isWiFiAvailable() -> Bool {
        do {
            if let reachability = Reachability.init() {
                let remoteHostStatus = reachability.currentReachabilityStatus
                
                if (remoteHostStatus == .reachableViaWiFi) {
                    return true
                }
                return false
            }
            return false
        }
    }
    
    static open func isMobileAvailable() -> Bool {
        do {
            if let reachability = Reachability.init() {
                
                let remoteHostStatus = reachability.currentReachabilityStatus
                
                if (remoteHostStatus == .reachableViaWWAN) {
                    return true
                }
                return false
            }
            
            return false
            
        } 
    }
}
