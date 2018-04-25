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
        
        return content.getAllSwiftTypeRanges(skipPrivate: skipPrivate)
    }
    
    public func prefix(with prefix: String) -> String? {
        
        guard var content = self.content() else {
            return nil
        }
        
        let ranges = content.getAllSwiftTypeRanges(skipPrivate: true)
        
        for range in ranges {
            
            if let substring = content.subsstring(with: range) {
                
                let components = substring.components(separatedBy: " ")
                
                let newSubstring = substring.replacingOccurrences(of: " ", with: " \(prefix)")
                content = content.replacingOccurrences(of: substring, with: newSubstring)
                
                print("range = \(range)")
                print("substring = \(substring)")
            }
            
            
        }
        
        return content
    }
}
