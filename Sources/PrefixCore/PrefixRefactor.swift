//
//  PrefixRefactor.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 5/1/18.
//

import Foundation
import Files

public class PrefixRefactor {
    
    public init() {
    }
    
    public func prefix(prefix: String, from fromFolder: Folder, to toFolder: Folder) throws {
        
        //STORE ALL POSSIBLE TYPES
        var allPossibleTypes = [String]()
        
        let fileManager = PrefixFiles()
        
        //GET ALL FILES
        guard let allFiles = fileManager.getAllSwiftFiles(folder: fromFolder) else {
            throw PrefixError(message: "Can't get all swift files")
        }
        
        //GET ALL SWIFT TYPE DECLARATIONS
        for file in allFiles {
            
            guard let content = file.content() else {
                throw PrefixError(message: "Can't get content from \(file.path)")
            }
            
            allPossibleTypes.append(contentsOf: content.getAllSwitfTypeDeclarations(skipPrivate: true))
        }
        
        print(allPossibleTypes.onlyTypes())
        
        for file in allFiles {
            
            print("Name: \(file.name), Path: \(file.path)")
            
            //GET CONTENT FROM FILE
            guard var content = file.content() else {
                throw PrefixError(message: "Can't get content from \(file.path)")
            }
            
            //FOR EACH TYPE
            for type in allPossibleTypes.onlyTypes() {
                
                content.debugRanges(for: type)
                
                for posibleEnd in swiftTypeDeclarationsPosibleEnds {
                    
                    for posibleBegin in swiftTypeDeclarationsPosibleBegins {
                        let search = "\(posibleBegin)\(type)\(posibleEnd)"
                        let replace = "\(posibleBegin)\(prefix)\(type)\(posibleEnd)"
                        content = content.replacingOccurrences(of: search, with: replace)
                    }
                }
                                
                try toFolder.createFile(named: "\(prefix)\(file.name)", contents: content)
            }
        }
    }
}
