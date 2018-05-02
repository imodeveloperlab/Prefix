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
                    
                    var containsPrivateType = false
                    
                    for privateType in swiftPrivateTypes {
                        if type.contains(privateType) {
                            containsPrivateType = true
                            continue
                        }
                    }
                    
                    if !containsPrivateType {
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
                if let swiftType = self.subsstring(with: NSMakeRange(0, self.count - end.count)) {
                    
                    let swiftTypeComponnents = swiftType.components(separatedBy: " ")
                    
                    //IF WE HAVE COMPONENTS
                    if swiftTypeComponnents.count == 2 {
                        
                        //AND COMPONENTS ARE NOT LOWERCASED
                        if swiftTypeComponnents[1] != swiftTypeComponnents[1].lowercased() {
                            
                            //WE RETURN IT AS SWIFT TYPE
                            return swiftType
                        }
                    }
                }
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
    
    /// Get ranges from string
    ///
    /// - Parameters:
    ///   - substring: Substring to search
    ///   - options: CompareOptions
    ///   - locale: Locale
    /// - Returns: [Range<Index>]
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = self.range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
    
    func getAllRanges(for string: String) -> [NSRange] {
        
        var allRanges = [NSRange]()
        
        for range in self.ranges(of: string) {
            
            var alreadyContained = false
            
            let nsRange = string.nsRange(from: range)
            
            for knownRange in allRanges {
                if knownRange.location == nsRange.location &&
                    knownRange.length == nsRange.length {
                    alreadyContained = true
                }
            }
            
            var containProperEnd = false
            for end in swiftTypeDeclarationsPosibleEnds {
                let checkRange = NSMakeRange(nsRange.location + nsRange.length, end.count)
                if self.subsstring(with: checkRange) == end {
                    containProperEnd = true
                }
            }
            
            if !alreadyContained && containProperEnd {
                allRanges.append(nsRange)
            }
        }
        
        return allRanges
    }
    
    public func getAllSwiftTypeRanges(skipPrivate: Bool = false) -> [NSRange] {
        
        var allRanges = [NSRange]()

        for type in getAllSwitfTypeDeclarations(skipPrivate: skipPrivate) {
            
            for range in self.ranges(of: type) {
                
                var alreadyContained = false
                
                let nsRange = type.nsRange(from: range)
                
                for knownRange in allRanges {
                    if knownRange.location == nsRange.location &&
                        knownRange.length == nsRange.length {
                        alreadyContained = true
                    }
                }
                
                var containProperEnd = false
                for end in swiftTypeDeclarationsPosibleEnds {
                    let checkRange = NSMakeRange(nsRange.location + nsRange.length, end.count)
                    if self.subsstring(with: checkRange) == end {
                        containProperEnd = true
                    }
                }
                
                if !alreadyContained && containProperEnd {
                    allRanges.append(nsRange)
                }
            }
        }
        
        return allRanges
    }
    
    public func getAllSwiftTypeRanges(skipPrivate: Bool = false, skipPrefix prefix: String) -> [NSRange] {
        
        var allRanges = [NSRange]()
        
        for range in getAllSwiftTypeRanges(skipPrivate: skipPrivate) {
            
            let substring = self.subsstring(with: NSMakeRange(range.location - prefix.count, prefix.count))
            
            if substring == prefix {
                continue
            }
            
            allRanges.append(range)
            
        }
        
        return allRanges
    }
    
    public func toPrefix() -> String {
        
        let letters = filter() { ("A"..."Z").contains($0) }
        
        var prefix = ""
        
        for letter in letters {
            prefix.append(letter)
        }
        
        return prefix
    }
    
    public func debugRanges(for string: String) {
        
        let allRanges = self.getAllRanges(for: string)
        
        for range in allRanges {
            if var substring = self.subsstring(with: NSMakeRange(range.location - 5, string.count + 10)) {
                
                substring = substring.replacingOccurrences(of: "\n", with: "")
                
                print("String: \(string) Range: \(range) Context: \(substring)")
            }
        }
    }
}

public extension Array where Element == String {
    
    public func onlyTypes() -> [String] {
        
        var allTypes = [String]()
        
        for type in self {
            
            let components = type.components(separatedBy: " ")
            if components.count == 2 {
                allTypes.append(components[1])
            }
        }
        
        allTypes = Array(Set(allTypes))
        return allTypes
    }
    
}

public extension StringProtocol where Index == String.Index {
    public func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}
