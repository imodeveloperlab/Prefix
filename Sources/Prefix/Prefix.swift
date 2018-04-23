//
//  Prefix.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation
import Files

class Prefix {
    
    func getFiles(filter pattern: PrefixParserPattern? = nil) -> [File]? {
        
        var files = [File]()
        for file in Folder.current.files {
            if let pattern = pattern {
                if file.name.contain(pattern: pattern) {
                    files.append(file)
                }
            } else {
                files.append(file)
            }
        }
        return files
    }
}
