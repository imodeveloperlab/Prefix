//
//  PrefixParser.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation

public enum PrefixParserPatternTag {}
public typealias PrefixParserPattern = PrefixTypedValue<PrefixParserPatternTag, String>

public let swiftTypeDeclarationsPosibleEnds = [" ", ":", "{", "?"]
public let swiftTypes = ["class", "protocol", "extension", "enum", "struct"]
public let swiftPrivateTypes = ["UIView", "UIViewController", "String", "NSRegularExpression"]

public class PrefixParser {
    
    private static var cachedRegularExpressions: [String: NSRegularExpression] = [:]
    
    /// Create PrefixParserPattern which will check if string contain word
    ///
    /// - Parameter word: Word to be contained
    /// - Returns: PrefixParserPattern
    public static func containWord(_ word: String) -> PrefixParserPattern {
        return PrefixParserPattern("(?:\\\(word))")
    }
    
    /// Create contain Swift Type Declaration
    ///
    /// - Parameter type: String
    /// - Returns: PrefixParserPattern
    public static func containSwiftTypeDeclarations(_ type: String) -> [PrefixParserPattern] {
        
        var patterns = [PrefixParserPattern]()
        for end in swiftTypeDeclarationsPosibleEnds {
            patterns.append(PrefixParserPattern("(?:\(type))(?:\\ )\\w+(?:\\\(end))"))
        }
        
        return patterns
    }
    
    /// Get elements from string
    ///
    /// - Parameters:
    ///   - text: String
    ///   - pattern: PrefixParserPattern
    ///   - range: NSRange
    /// - Returns: [NSTextCheckingResult]
    public static func getElements(from text: String,
                            with pattern: PrefixParserPattern,
                            range: NSRange) -> [NSTextCheckingResult] {
        
        guard let elementRegex = regularExpression(for: pattern) else { return [] }
        return elementRegex.matches(in: text, options: [], range: range)
    }
    
    /// Make an regular expresion
    ///
    /// - Parameter pattern: PrefixParserPattern
    /// - Returns: NSRegularExpression?
    public static func regularExpression(for pattern: PrefixParserPattern) -> NSRegularExpression? {
        
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
