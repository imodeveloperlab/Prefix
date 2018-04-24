//
//  StringExtension.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation

public extension String {
    
    public func match(_ word: String) -> Bool {
        return self.contains(PrefixParser.mathWord(word))
    }
    
    public func contains(_ pattern: PrefixParserPattern) -> Bool {
        if !PrefixParser.getElements(from: self, with: pattern, range: NSMakeRange(0, self.count)).isEmpty {
            return true
        }
        return false
    }
}
