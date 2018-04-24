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
        XCTAssertTrue(".swift".contains(PrefixParserPattern("(?:\\.swift)")))
        
        //TO NOT contain .swift
        XCTAssertTrue(!"swift".contain(".swift"))
        
        //TO contain .swift
        XCTAssertTrue(".swift".contain(".swift"))
    }
}
