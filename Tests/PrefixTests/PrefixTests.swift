import Foundation
import XCTest
import PrefixCore

class PrefixTests: XCTestCase {
    
    func testStringExtension() {
        
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
        
        //TO NOT contain .swift
        XCTAssertTrue(!"swift".contains(".swift"))
        
        //TO contain .swift
        XCTAssertTrue(".swift".contains(".swift"))
        
        //ENDS WITH .swift
        XCTAssertTrue(".swiftsometext_swift_sometext.swift".endsWith(".swift"))
        
        //NOT ENDS WITH .swift
        XCTAssertTrue(!".swiftsometext_swift_sometext".endsWith(".swift"))
    }
}
