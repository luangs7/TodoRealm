//
//  Exception.swift
//
//  Created by Livetouch
//  Updated by Luan Silva
//



import Foundation

public enum ExceptionType: Error {
    
    case ioException
    case networkUnavailableException
    case jsonException
    case fileNotFoundException
    case appSecurityTransportException
    case notImplemented
    
    case domainException(message: String)
    case runTimeException(message: String)
    case genericException(message: String)
}


public class Exception: NSObject {
    
    //MARK: - Get Messages
    static open func getExceptionMessage(_ exception: ExceptionType) -> String {
        
        var exceptionTag = ""
        
        switch exception {
        case .ioException:
            exceptionTag = "io_error"
            
        case .networkUnavailableException:
            exceptionTag = "network_unavailable_error"
            
        case .genericException(let message):
            if (StringUtils.isNotEmpty(message)) {
                return message
            }
            exceptionTag = "generic_error"
            
        default:
            return exceptionTag
        }
        
        let msg = "need to set default messages"
        
        return msg
    }
    
    static open func getDBExceptionMessage(_ exception: Error) -> String {
        var errorMessage = ""
        
        switch exception {
        case ExceptionType.notImplemented:
            errorMessage = "AppDelegate não é subclasse de BaseAppDelegate."
            
            //XXX:
//        case ExceptionType.databaseHelperNotFound:
//            errorMessage = "Não foi encontrado uma subclasse de DatabaseHelper."
            
//        case ExceptionType.notImplemented(let message):
//            errorMessage = "Não foi implementado o método '\(message)' na subclasse de DatabaseHelper."
            
        default:
            break
        }
        
        return errorMessage
    }
    
    static open func getIOExceptionMessage() -> String {
        return getExceptionMessage(.ioException)
    }
    
    static open func getGenericMessage() -> String {
        return getExceptionMessage(.genericException(message: ""))
    }
    
    static open func getAppTransportSecurityMessage() -> String {
        return "Configure o atributo 'NSAppTransportSecurity' no seu Info.plist."
    }
    
    //MARK: - Alert Messages
    static open func alertException(_ exception: Error) {
        AlertUtils.alert("Exception Err")
    }
    
    static open func alertIOException() {
        AlertUtils.alert(getIOExceptionMessage())
    }
    
    static open func alertGenericException() {
        AlertUtils.alert(getGenericMessage())
    }
    
    static open func alertAppTransportSecurityException() {
        AlertUtils.alert(getAppTransportSecurityMessage())
    }
}

