//
//  PrefixParserTests.swift
//  PrefixTests
//
//  Created by Borinschi Ivan on 4/25/18.
//

import Foundation
import XCTest
import PrefixCore
import Files

class PrefixParserTests: XCTestCase {
    
    func testGetRegularExpression() {
        XCTAssertNotNil(PrefixParser.regularExpression(for: PrefixParser.containWord("class")))
    }
    
    func testGetElements() {
        
        let string = "class PrefixTestFile1{ } public final class PrefixTestFile: NSObject {} public final class PrefixTestFile {}"
        let range = NSMakeRange(0, string.count)
        var result = [NSTextCheckingResult]()
        
        for pattern in PrefixParser.containSwiftTypeDeclarations("class") {
            
            result.append(contentsOf: PrefixParser.getElements(from: string,
                                                               with: pattern,
                                                               range: range))
        }
        
        XCTAssertEqual(result.count, 3)
    }
}
