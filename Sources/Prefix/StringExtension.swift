//
//  StringExtension.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation

extension String {
    
    func contain(pattern: PrefixParserPattern) -> Bool {
        if !PrefixParser.getElements(from: self, with: pattern, range: NSMakeRange(0, self.count)).isEmpty {
            return true
        }
        return false
    }
}
