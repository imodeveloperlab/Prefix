//
//  FileExtension.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/24/18.
//

import Foundation
import Files

public extension File {
    
    public func content() -> String? {
        do {
            return try String(contentsOfFile: self.path, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
    
    public func getAllSwitfTypeDeclarations(skipPrivate: Bool = false) -> [String]? {
        
        guard let content = self.content() else {
            return nil
        }
        
        return content.getAllSwitfTypeDeclarations(skipPrivate: true)
    }
    
    public func getAllSwiftTypeRanges(skipPrivate: Bool = false) -> [NSRange]? {
        
        guard let content = self.content() else {
            return nil
        }
        
        return content.getAllSwiftTypeRanges()
    }
}
