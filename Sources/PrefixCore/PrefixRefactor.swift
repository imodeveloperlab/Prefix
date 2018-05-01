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
        
        var allPossibleTypes = [String]()
        
        let files = PrefixFiles()
        
        guard let allFiles = files.getAllSwiftFiles(folder: fromFolder) else {
            throw PrefixError(message: "Can't get all swift files")
        }
        
        for file in allFiles {
            
            guard let content = file.content() else {
                throw PrefixError(message: "Can't get content from \(file.path)")
            }
            
            allPossibleTypes.append(contentsOf: content.getAllSwitfTypeDeclarations(skipPrivate: true))
        }
        
        for file in allFiles {
            
            guard var content = file.content() else {
                throw PrefixError(message: "Can't get content from \(file.path)")
            }
            
            for type in allPossibleTypes {
                
                let components = type.components(separatedBy: " ")
                
                if components.count == 2 {
                    
                    let replace = components[1]
                    let with = "\(prefix)\(components[1])"
                    
                    if let checkRange = content.range(of: replace) {
                        let nsRange = content.nsRange(from: checkRange)
                        let substring = content.subsstring(with: NSMakeRange(nsRange.location - prefix.count, prefix.count))
                        if substring == prefix {
                            continue
                        }
                    }
                    
                    content = content.replacingOccurrences(of: replace, with: with)
                    try toFolder.createFile(named: "\(prefix)\(file.name)", contents: content)
                }
            }
        }
    }
}
