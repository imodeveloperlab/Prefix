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
}
