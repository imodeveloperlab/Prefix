//
//  StringExtension.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation

public extension String {
    
    public func endsWith(_ word: String) -> Bool {
        let _self = self as NSString
        let range = NSMakeRange(_self.length - word.count, word.count)
        let newString = _self.substring(with: range)
        return newString == word
    }
    
    public func contains(_ pattern: PrefixParserPattern) -> Bool {
        if !PrefixParser.getElements(from: self, with: pattern, range: NSMakeRange(0, self.count)).isEmpty {
            return true
        }
        return false
    }
}
