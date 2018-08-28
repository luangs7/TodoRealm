//
//  FileUtils.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 24/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

open class FileUtils: NSObject {
    
    
    /*
     *  Para o uso dessa classe é importante saber as diferenças entre o Main Bundle e o diretório Documents.
     *  O Main Bundle contém os arquivos que são enviados junto com o projeto. Arquivos no Main Bundle são read-only (possuem somente permissão de leitura). Até o iOS 5, atualizações no aplicativo causavam substituição de todos os arquivos no Main Bundle. A partir do iOS 6, atualizações no aplicativo causam substituição somente dos arquivos alterados no Main Bundle.
     *  O diretório Documents contém os arquivos baixados pelo aplicativo, por exemplo pela câmera ou pela Internet. Arquivos no Documents são read-write (possuem permissão de leitura e escrita). Um aplicativo recém-instalado já cria um diretório Documents para uso, começando com espaço utilizado de 0 (zero) MB. Atualizações no aplicativo não afetam os arquivos armazenados no Documents.
     */
    
    static open func exists(atPath path: String) -> Bool {
        let b = FileManager.default.fileExists(atPath: path);
        return b
    }
    
    // Caminho do banco de dados
    static open func getFilePathAtDocuments(_ nome: String) -> String {
        let path = NSHomeDirectory() + "/Documents/" + nome
        return path
    }
    
    //MARK: - Default Messages
    /*
    static open func getUtilsDefaultMessage(tag: String) -> String {
        
        guard StringUtils.isNotEmpty(tag) else {
            return ""
        }
        
        let appDelegate = AppDelegate.shared()
        let filename = appDelegate.getConfig()
        
        var fileData = try? getBundleFile(filename as! String, ofType: nil)
        if (fileData == nil) {
            fileData = try? getLibFile(filename as! String, ofType: nil)
        }
        
        do {
            guard fileData != nil else {
                return "Arquivo '\(filename)' não se encontra no projeto."
            }
//            let dict = try JSON.toDictionary(fileData)
//            
//            return dict.getStringWithKey(tag)
            return ""
            
        }
        return ""
    } */
    
    //MARK: - Paths
    
    static open func getDocumentsPath(_ domainMask: FileManager.SearchPathDomainMask = .userDomainMask) throws -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, domainMask, true)
        if documentPaths.isEmpty {
            throw ExceptionType.fileNotFoundException
        }
        
        let documentDirectory = documentPaths[0]
        return documentDirectory
    }
    
    static open func getPathOfDocumentFile(_ filename: String, withDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) throws -> String {
        if filename.isEmpty {
            throw ExceptionType.fileNotFoundException
        }
        
        let documentPath = try getDocumentsPath(domainMask)
        
        let filePath = documentPath.stringByAppendingPathComponent(path: filename)
        return filePath
    }
    
    static open func getPathOfBundleFile(_ filename: String, ofType type: String?) throws -> String {
        if let path = Bundle.main.path(forResource: filename, ofType: type) {
            return path
        }
        throw ExceptionType.fileNotFoundException
    }
    
    static open func getPathOfPodBundleFile(_ filename: String, ofType type: String?, atPod podBundle: Bundle) throws -> String {
        if let path = podBundle.path(forResource: filename, ofType: type) {
            return path
        }
        throw ExceptionType.fileNotFoundException
    }
    
    static open func getResourcePathOfFile(_ filename: String) throws -> String {
        guard let resourcePath = Bundle.main.resourcePath else {
            throw ExceptionType.fileNotFoundException
        }
        
        let path = resourcePath.stringByAppendingPathComponent(path: filename)
        return path
    }
    
    //MARK: - Copying Files
    
    static open func copyFileFromBundleToDocuments(_ filename: String) throws {
        let fileManager = FileManager.default
        
        let filePath = try getPathOfDocumentFile(filename)
        
        let exists = fileManager.fileExists(atPath: filePath)
        if exists {
            try removeFileFromDocuments(filename)
        }
        
        let filePathFromApp = try getResourcePathOfFile(filename)
        
        do {
            try fileManager.copyItem(atPath: filePathFromApp, toPath: filePath)
            
        } catch {
            print("Failed to copy '\(filename)' from bundle to documents.")
            throw ExceptionType.fileNotFoundException
        }
    }
    
    static open func copyFilesFromBundleToDocuments(_ filenames: [String]) throws {
        if filenames.isEmpty {
            throw ExceptionType.fileNotFoundException
        }
        
        for filename in filenames {
            try copyFileFromBundleToDocuments(filename)
        }
    }
    
    //MARK: - Bundle
    
    //MARK: Get
    
    static open func getBundleFile(_ filename: String, ofType type: String?) throws -> Data {
        let filePath = try getPathOfBundleFile(filename, ofType: type)
        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            return fileData
        }
        throw ExceptionType.fileNotFoundException
    }
    
    //MARK: Read
    
    static open func readBundleFileWithName(_ filename: String, ofType type: String?, withEncoding encoding: String.Encoding = String.Encoding.utf8) throws -> String {
        let path = try getPathOfBundleFile(filename, ofType: type)
        return try readBundleFileAtPath(path)
    }
    
    static open func readBundleFileAtPath(_ filePath: String, withEncoding encoding: String.Encoding = String.Encoding.utf8) throws -> String {
        do {
            let text = try String(contentsOfFile: filePath, encoding: encoding)
            return text
            
        } catch {
            throw ExceptionType.genericException(message: "")
        }
    }
    
    //MARK: - Lib
    
    static open func getLibBundle() -> Bundle {
        return Bundle(for: self.classForCoder())
    }
    
    //MARK: Get
    
    static open func getLibFile(_ filename: String, ofType type: String?) throws -> Data {
        let libBundle = getLibBundle()
        let filePath = try getPathOfPodBundleFile(filename, ofType: type, atPod: libBundle)
        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            return fileData
        }
        throw ExceptionType.fileNotFoundException
    }
    
    //MARK: - Documents
    
    //MARK: Exists
    
    static open func fileExistsInDocuments(_ filename: String) -> Bool {
        do {
            let path = try getPathOfDocumentFile(filename)
            return FileManager.default.fileExists(atPath: path)
            
        } catch {
            return false
        }
    }
    
    static open func filePathExistsInDocuments(_ filePath: String) -> Bool {
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    //MARK: Get
    
    static open func getDocumentsFile(_ filename: String) throws -> Data {
        let path = try getPathOfDocumentFile(filename)
        let data = try getDocumentsFileAtPath(path)
        return data
    }
    
    static open func getDocumentsFileAtPath(_ filePath: String) throws -> Data {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            return data
        }
        throw ExceptionType.genericException(message: "")
    }
    
    //MARK: Read
    
    static open func readDocumentsFile(_ filename: String, withEncoding encoding: String.Encoding = String.Encoding.utf8) throws -> String {
        let path = try getPathOfDocumentFile(filename, withDomainMask: .allDomainsMask)
        let text = try readDocumentsFileAtPath(path, withEncoding: encoding)
        return text
    }
    
    static open func readDocumentsFileAtPath(_ filePath: String, withEncoding encoding: String.Encoding = String.Encoding.utf8) throws -> String {
        do {
            let text = try String(contentsOfFile: filePath, encoding: encoding)
            return text
        } catch {
            throw ExceptionType.fileNotFoundException
        }
    }
    
    //MARK: Write
    
    static open func writeInDocuments(_ text: String, onFile filename: String, withEncoding encoding: String.Encoding = String.Encoding.utf8) throws {
        let path = try getPathOfDocumentFile(filename, withDomainMask: .allDomainsMask)
        try writeInDocuments(text, onFileAtPath: path, withEncoding: encoding)
    }
    
    static open func writeInDocuments(_ text: String, onFileAtPath filePath: String, withEncoding encoding: String.Encoding = String.Encoding.utf8) throws {
        do {
            try text.write(toFile: filePath, atomically: false, encoding: encoding)
        } catch {
            throw ExceptionType.genericException(message: "")
        }
    }
    
    //MARK: Append
    
    static open func appendText(_ text: String, onFile filename: String, ofType type: String?) throws {
        var fullFileName = ""
        if let type = type {
            fullFileName = "\(filename).\(type)"
        } else {
            fullFileName = filename
        }
        
        let currentText = try readDocumentsFile(fullFileName)
        let newText = "\(currentText)\n\(text)"
        try writeInDocuments(newText, onFile: fullFileName)
    }
    
    static open func appendText(_ text: String, onFileAtPath filePath: String) throws {
        let currentText = try readDocumentsFileAtPath(filePath)
        let newText = "\(currentText)\n\(text)"
        try writeInDocuments(newText, onFileAtPath: filePath)
    }
    
    //MARK: Removes
    static open func removeFileFromDocumentsAtPath(_ filePath: String) throws {
        do {
            try FileManager.default.removeItem(atPath: filePath)
            
        } catch {
            print("Failed to remove '\(filePath)' from documents.")
            throw ExceptionType.genericException(message: "")
        }
    }
    
    static open func removeFileFromDocuments(_ filename: String) throws {
        let filePath = try getPathOfDocumentFile(filename)
        try removeFileFromDocumentsAtPath(filePath)
    }
    
    static open func removeFilesFromDocuments(_ filenames: [String]) throws {
        if filenames.isEmpty {
            throw ExceptionType.fileNotFoundException
        }
        
        for filename in filenames {
            try removeFileFromDocuments(filename)
        }
    }
    
    //MARK: - Directories
    static open func createDirectoriesAtPath(_ path: String) throws {
        let exists = fileExistsInDocuments(path)
        if !exists {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                throw ExceptionType.genericException(message: "")
            }
        }
    }
}
