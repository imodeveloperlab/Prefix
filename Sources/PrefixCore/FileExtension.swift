//
//  FileExtension.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/24/18.
//

import Foundation
import Files

public extension File {
    
    public func content() -> String? {
        do {
            return try String(contentsOfFile: self.path, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
    
    public func getAllContentRanges(for pattern: PrefixParserPattern) -> [NSRange]? {
        
        guard let content = self.content() else {
            return nil
        }
        
        return nil
        
//        var count = 0
//        let length = content.count
//        var range = NSMakeRange(0, length)
//        let string = content as NSString
//
//
//        while(range.location != NSNotFound) {
//
//
//
//            content.range(of: <#T##StringProtocol#>, options: <#T##String.CompareOptions#>, range: <#T##Range<String.Index>?#>, locale: <#T##Locale?#>)
//
//            range = [[mutableAttributedString string] rangeOfString:word options:0 range:range];
//            if(range.location != NSNotFound) {
//                [mutableAttributedString setTextColor:color range:NSMakeRange(range.location, [word length])];
//                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
//                count++;
//            }
//        }
//
//        return mutableAttributedString;
//
//        return nil
    }
}
