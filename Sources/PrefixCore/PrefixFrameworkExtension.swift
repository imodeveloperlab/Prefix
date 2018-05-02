//
//  PrefixFrameworkExtension.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/30/18.
//

import Files

public extension PrefixFramework {
    
    public func fromFolder(with root: Folder) throws -> Folder {
        let from = try root.subfolder(named: "from")
        let folder = try from.subfolder(atPath: "\(originalName)/\(fromPath)")
        return folder
    }
    
    public func clearDestinationFolder(root: Folder) throws {
        
        let to = try root.subfolder(named: "to")
        
        if to.containsSubfolder(named: finalName) {
            
            let destinationFolder = try to.subfolder(atPath: finalName)
            let prefix = PrefixFiles()
            if let filesToDelete = prefix.getFilesFrom(folder: destinationFolder) {
                for file in filesToDelete {
                    try file.delete()
                }
            }
        }
    }
    
    public func toFolder(with root: Folder) throws -> Folder {
        
        let to = try root.subfolder(named: "to")
        
        if !to.containsSubfolder(named: finalName) {
            try to.createSubfolder(named: finalName)
        }
        
        let folder = try to.subfolder(atPath: "\(finalName)")
        return folder
    }
}
