//
//  StringExtension.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation

public extension String {
    
    /// Check if string ends with string
    ///
    /// - Parameter word: String
    /// - Returns: Bool
    public func endsWith(_ word: String) -> Bool {
        let _self = self as NSString
        let range = NSMakeRange(_self.length - word.count, word.count)
        let newString = _self.substring(with: range)
        return newString == word
    }
    
    /// Check if string contains pattern
    ///
    /// - Parameter pattern: PrefixParserPattern
    /// - Returns: Bool
    public func contains(_ pattern: PrefixParserPattern) -> Bool {
        if !PrefixParser.getElements(from: self, with: pattern, range: NSMakeRange(0, self.count)).isEmpty {
            return true
        }
        return false
    }
    
    /// Check if string contains array of patterns
    ///
    /// - Parameter patterns: [PrefixParserPattern]
    /// - Returns: Bool
    public func contains(_ patterns: [PrefixParserPattern]) -> Bool {
        
        for pattern in patterns {
            if contains(pattern) {
                return true
            }
        }
        
        return false
    }

    /// Get all matches from string
    ///
    /// - Parameter pattern: PrefixParserPattern
    /// - Returns: Optional array of strings
    public func getAllMatches(for pattern: PrefixParserPattern) -> [String] {
        
        var stringsArray = [String]()
        let elements = PrefixParser.getElements(from: self, with: pattern, range: NSMakeRange(0, self.count))
        
        for element in elements {
            if let substring = self.subsstring(with: element.range) {
                stringsArray.append(substring)
            }
        }
        
        return stringsArray
    }
    
    /// Get all matches from string for array of patterns
    ///
    /// - Parameter pattern: PrefixParserPattern
    /// - Returns: Optional array of strings
    public func getAllMatches(for patterns: [PrefixParserPattern]) -> [String] {
        
        var stringsArray = [String]()
        for pattern in patterns {
            stringsArray.append(contentsOf: getAllMatches(for: pattern))
        }        
        return stringsArray
    }
    
    /// Get all matches from string for array of array of patterns
    ///
    /// - Parameter pattern: PrefixParserPattern
    /// - Returns: Optional array of strings
    public func getAllMatches(for patterns: [[PrefixParserPattern]]) -> [String] {
        var stringsArray = [String]()
        for arrayOfPatterns in patterns {
            stringsArray.append(contentsOf: getAllMatches(for: arrayOfPatterns))
        }
        return stringsArray
    }
    
    /// Get all matches swift declaration type matches from string for array of patterns
    ///
    /// - Parameter pattern: PrefixParserPattern
    /// - Returns: Optional array of strings
    public func getAllSwitfTypeMatches(for patterns: [PrefixParserPattern], skipPrivate: Bool = false) -> [String] {
        
        var stringsArray = [String]()
        let allMatches = getAllMatches(for: patterns)

        for match in allMatches {
            
            if let type = match.toSwiftDecarationType() {
                
                if skipPrivate {
                    
                    var contains = false
                    
                    for privateType in swiftPrivateTypes {
                        if type.contains(privateType) {
                            contains = true
                            continue
                        }
                    }
                    
                    if !contains {
                        stringsArray.append(type)
                    }
                    
                } else {
                    stringsArray.append(type)
                }
            }
        }
        
        return stringsArray
    }
    
    /// Get all swift type declarations
    ///
    /// - Returns: [String]
    public func getAllSwitfTypeDeclarations(skipPrivate: Bool = false) -> [String] {
        
        var stringsArray = [String]()
        
        for type in swiftTypes {
            
            let allMatches = getAllSwitfTypeMatches(for: PrefixParser.containSwiftTypeDeclarations(type),
                                                    skipPrivate: skipPrivate)
            if !allMatches.isEmpty {
                stringsArray.append(contentsOf: allMatches)
            }
        }
        
        return stringsArray
    }
    
    /// Check if string ends with one of swiftTypeDeclarationsPosibleEnds and try to remove it
    ///
    /// - Returns: Optional string
    func toSwiftDecarationType() -> String? {
        for end in swiftTypeDeclarationsPosibleEnds {
            if self.endsWith(end) {
                return self.subsstring(with: NSMakeRange(0, self.count - end.count))
            }
        }
        return nil
    }
    
    /// Substring with NSRange
    ///
    /// - Parameter range: NSRange
    /// - Returns: Optional string
    func subsstring(with range: NSRange) -> String? {
        let string = self as NSString
        return string.substring(with: range)
    }
    
}
