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
        
        for type in types {
            
            let components = type.components(separatedBy: " ")
            
            if components.count == 2 {
                
                let replace = components[1]
                let with = "\(prefix)\(components[1])"
                
                print("\(replace) with \(with)")
                
                let ranges = content.getAllRanges(for: components[1])

                content = content.replacingOccurrences(of: replace, with: with)
                print(content)
            }
        }
        
        return content
    }
}
