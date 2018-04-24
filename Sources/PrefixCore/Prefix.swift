//
//  Prefix.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation
import Files

public class Prefix {
    
    public init() {
    }
    
    public func getFilesFrom(folder: Folder, pattern: PrefixParserPattern? = nil) -> [File]? {
        
        var files = [File]()
        for file in folder.files {
            if let pattern = pattern {
                if file.name.contains(pattern) {
                    files.append(file)
                }
            } else {
                files.append(file)
            }
        }
        
        return files
    }
    
    public func getFilesFromCurrentFolder(filter pattern: PrefixParserPattern? = nil) -> [File]? {
        return getFilesFrom(folder: Folder.current, pattern: pattern)
    }
}
