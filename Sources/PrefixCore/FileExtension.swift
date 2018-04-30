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
        
        guard var content = self.content(),
              let types = getAllSwitfTypeDeclarations(skipPrivate: true) else {
            return nil
        }
        
        print("Found types: \(types)")
        
        for type in types {
            
            let components = type.components(separatedBy: " ")
            
            if components.count == 2 {
                
                let ranges = content.getAllRanges(for: components[1])
                
                for range in ranges {
                    
                    if let substring = content.subsstring(with: range) {
                        
                        content = content.replacingOccurrences(of: substring, with: "\(prefix)\(substring)")
                    }
                }
            }
        }
        
        return content
    }
}
