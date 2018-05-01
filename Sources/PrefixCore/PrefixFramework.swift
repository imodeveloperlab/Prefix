//
//  PrefixFramework.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/30/18.
//

import Foundation

public struct PrefixFramework {
    
    var originalName: String
    var finalName: String
    var fromPath: String
    
    public init(originalName: String,
                finalName: String,
                fromPath: String) {
        
        self.originalName = originalName
        self.finalName = finalName
        self.fromPath = fromPath
    }
}
