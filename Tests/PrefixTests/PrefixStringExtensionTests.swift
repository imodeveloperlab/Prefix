//
//  PrefixStringExtensionTests.swift
//  PrefixTests
//
//  Created by Borinschi Ivan on 4/25/18.
//

import Foundation
import XCTest
import PrefixCore
import Files

class PrefixStringExtensionTests: XCTestCase {
    
    func testContains() {
        
        //TO NOT CONTAIN .swift
        XCTAssertTrue(!"swift".contains(PrefixParserPattern("(?:\\.swift)")))
        
        //CONTAIN .swift
        XCTAssertTrue(".swift".contains(PrefixParserPattern("(?:\\.swift)")))
        
        //TO NOT CONTAIN .swift
        XCTAssertTrue(!"sometext_swift_sometext".contains(PrefixParserPattern("(?:\\.swift)")))
        
        //CONTAIN .swift
        XCTAssertTrue("sometext_swift_sometext.swift".contains(PrefixParserPattern("(?:\\.swift)")))
        
        //CONTAIN .swift
        XCTAssertTrue(".swiftsometext_swift_sometext".contains(PrefixParserPattern("(?:\\.swift)")))
    }
    
    func testContainsDeclaration() {
        let classPattern = PrefixParser.containSwiftTypeDeclarations("class")
        XCTAssertTrue("public final class ImoTableView : UIView, UITableViewDelegate".contains(classPattern))
        XCTAssertTrue("public final class ImoTableView: UIView, UITableViewDelegate".contains(classPattern))
        XCTAssertTrue("public final class ImoTableView {".contains(classPattern))
        XCTAssertTrue("public final class ImoTableView{".contains(classPattern))
    }
    
    func testEndWith() {
        
        //ENDS WITH .swift
        XCTAssertTrue(".swiftsometext_swift_sometext.swift".endsWith(".swift"))
        
        //NOT ENDS WITH .swift
        XCTAssertTrue(!".swiftsometext_swift_sometext".endsWith(".swift"))
    }
    
    func testGetAllClassMatches() {
        
        let classPattern = PrefixParser.containSwiftTypeDeclarations("class")
        let testFile = PrefixTestFile()
        XCTAssertNotNil(testFile.content())
        XCTAssertEqual(testFile.content()?.getAllMatches(for: classPattern).count, 5)
    }
    
    func testGetAllProtocolMatches() {
        
        let classPattern = PrefixParser.containSwiftTypeDeclarations("protocol")
        let testFile = PrefixTestFile()
        XCTAssertNotNil(testFile.content())
        XCTAssertEqual(testFile.content()?.getAllMatches(for: classPattern).count, 7)
    }
    
    func testGetAllProtocolAndClassMatches() {
        
        let protocolPattern = PrefixParser.containSwiftTypeDeclarations("protocol")
        let classPattern = PrefixParser.containSwiftTypeDeclarations("class")
        
        let testFile = PrefixTestFile()
        XCTAssertNotNil(testFile.content())
        XCTAssertEqual(testFile.content()?.getAllMatches(for: [protocolPattern, classPattern]).count, 12)
    }
    
    func testGetAllSwitfTypeDeclarations() {
        
        let testFile = PrefixTestFile()
        XCTAssertNotNil(testFile.content())
        XCTAssertEqual(testFile.content()?.getAllSwitfTypeDeclarations().count, 15)
    }
    
    func testGetAllSwitfTypeDeclarationsSkipPrivate() {
        
        let testFile = PrefixTestFile()
        XCTAssertNotNil(testFile.content())
        XCTAssertEqual(testFile.content()?.getAllSwitfTypeDeclarations(skipPrivate: true).count, 8)
    }
    
    func testToSwiftDecarationType() {
        for end in swiftTypeDeclarationsPosibleEnds {
            XCTAssertEqual("class SomeClass\(end)".toSwiftDecarationType(), "class SomeClass")
        }
        
        for end in swiftTypeDeclarationsPosibleEnds {
            XCTAssertNotEqual("class SomeClass\(end)abc".toSwiftDecarationType(), "class SomeClass")
        }
    }
    
    func testRanges() {
        let string = "class ImoTableView {} class ImoTableView {} class ImoTableView {}"
        XCTAssertEqual(string.ranges(of: "class").count, 3)
    }
    
    func testGetAllSwiftTypeRanges() {
        
        let testFile = PrefixTestFile()
        XCTAssertNotNil(testFile.content())
        let ranges = testFile.content()?.getAllSwiftTypeRanges()
        XCTAssertEqual(ranges?.count, 15)
    }
}
