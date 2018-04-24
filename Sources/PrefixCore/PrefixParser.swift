//
//  PrefixParser.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation

public enum PrefixParserPatternTag {}
public typealias PrefixParserPattern = PrefixTypedValue<PrefixParserPatternTag, String>

public class PrefixParser {
    
    private static var cachedRegularExpressions: [String: NSRegularExpression] = [:]
    
    static func mathWord(_ word: String) -> PrefixParserPattern {
        return PrefixParserPattern("(?:\\\(word))")
    }
    
    static func getElements(from text: String, with pattern: PrefixParserPattern, range: NSRange) -> [NSTextCheckingResult] {
        guard let elementRegex = regularExpression(for: pattern) else { return [] }
        return elementRegex.matches(in: text, options: [], range: range)
    }
    
    private static func regularExpression(for pattern: PrefixParserPattern) -> NSRegularExpression? {
        if let regex = cachedRegularExpressions[pattern.value] {
            return regex
        } else if let createdRegex = try? NSRegularExpression(pattern: pattern.value, options: [.caseInsensitive]) {
            cachedRegularExpressions[pattern.value] = createdRegex
            return createdRegex
        } else {
            return nil
        }
    }
}
