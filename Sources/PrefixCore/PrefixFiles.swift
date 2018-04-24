//
//  Prefix.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation
import Files

public class PrefixFiles {
    
    public init() {
    }
    
    /// Get all swift files in directory
    ///
    /// - Parameter folder: Folder
    /// - Returns: Optional array of Files
    public func getAllSwiftFiles(folder: Folder) -> [File]? {
        return getFilesFrom(folder: folder, contain: ".swift")
    }
 
    /// Get files from
    ///
    /// - Parameters:
    ///   - folder: Folder
    ///   - name: name to check if file name contain this contain
    /// - Returns: Optional array of Files
    public func getFilesFrom(folder: Folder, contain name: String) -> [File]? {
        return getFilesFrom(folder: folder,  contain: PrefixParser.containWord(name))
    }
    
    /// Get all files from current directory if files names contain pattern
    ///
    /// - Parameter pattern: PrefixParserPattern
    /// - Returns: Optional array of Files
    public func getFilesFromCurrentFolder(contain pattern: PrefixParserPattern? = nil) -> [File]? {
        return getFilesFrom(folder: Folder.current, contain: pattern)
    }
    
    /// Get all files from Folder if file names contain pattern
    ///
    /// - Parameters:
    ///   - folder: Folder
    ///   - pattern: PrefixParserPattern
    /// - Returns: Optional array of Files
    public func getFilesFrom(folder: Folder, contain pattern: PrefixParserPattern? = nil) -> [File]? {
        
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
}
