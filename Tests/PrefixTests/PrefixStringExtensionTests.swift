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
        XCTAssertEqual(testFile.content()?.getAllMatches(for: classPattern).count, 3)
    }
    
    func testGetAllProtocolMatches() {
        
        let classPattern = PrefixParser.containSwiftTypeDeclarations("protocol")
        let testFile = PrefixTestFile()
        XCTAssertNotNil(testFile.content())
        XCTAssertEqual(testFile.content()?.getAllMatches(for: classPattern).count, 6)
    }
}
