//
//  ServiceException.swift
//  TodoRealm
//
//  Created by Retina on 8/28/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit


public enum ServiceExceptionType: Error {
    
    case facebookLoginError
    case zipCode
    
    case objectSerialization(message: String)
    case responseException(message: String)
}

class ServiceException {
    
    //TODO: terminar handle de multiplos alertas
    static open var didPresentAlert: Bool = false
    static private var appName = ""
    
    static open func withStatusCode(_ code: Int) {
        self.alertExceptionWith(code: code)
        appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    }
    
    static open func withType(_ type: ServiceExceptionType) {
        self.alertExceptionWith(type: type)
        appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    }
    
    static private func alertExceptionWith(type: ServiceExceptionType) {
        switch type {
            
        case .responseException(let message):
            AlertUtils.alert(appName, message: message, okText: "Ok")
            
        case .objectSerialization(let message):
            AlertUtils.alert(appName, message: message, okText: "Ok")
            
        case .facebookLoginError:
            AlertUtils.alert(appName, message: "Problema ao realizar login com Facebook. Tente novamente!", okText: "Ok")
            
        case .zipCode:
            AlertUtils.alert(appName, message: "Problema ao realizar busca do CEP.", okText: "Ok")
            
        }
    }
    
    static private func alertExceptionWith(code: Int) {
        switch(code) {
            
        case NSURLErrorNotConnectedToInternet:
            AlertUtils.alert(appName, message: "Sem conexão com a internet. Verifique e tente novamente!", okText: "Ok")
            
        case NSURLErrorTimedOut:
            AlertUtils.alert(appName, message: "A reposta do servidor demorou muito. Tente novamente!", okText: "Ok")
            
        case NSURLErrorNetworkConnectionLost:
            AlertUtils.alert(appName, message: "A sua conexão com a internet caiu. Verifique e tente novamente!", okText: "Ok")
            
        case 500, 409:
            AlertUtils.alert(appName, message: "Erro interno de servidor", okText: "Ok")
        case 503:
            AlertUtils.alert(appName, message: "Servidor em manutenção, volte mais tarde!", okText: "Ok")
        case 401:
            //TODO: handle logout -> retornar fluxo para login quando vencer o token
            AlertUtils.alert(appName, message: "Sua sessão expirou, por favor faça seu login para continuar.", okText: "Ok")
            
        case 404:
            AlertUtils.alert(appName, message: "O servidor está fora do ar", okText: "Ok")
            
        case 422:
            AlertUtils.alert(appName, message: "Problema de autenticação - dados incorretos", okText: "Ok")
            
        //TODO: verificar errors 422 setar type para poder tratar retorno na controller
        case 406, 400:
            AlertUtils.alert(appName, message: "Erro ao processar dados. Tente novamente.", okText: "Ok")
            
        default:
            AlertUtils.alert(appName, message: "Ocorreu um erro ao acessar a internet. Tente novamente!", okText: "Ok")
            //            SentryClient.shared?.captureMessage("Ocorreu um erro de conexão com exception code não listado")
        }
        
    }
}
