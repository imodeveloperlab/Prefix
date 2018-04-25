//
//  PrefixTestFile.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/25/18.
//

import Foundation

/// Declaration class for PrefixTestFile
public final class PrefixTestFile: NSObject {
   
    public override init() {
        super.init()
    }
    
    /// Read and return content from an file
    ///
    /// - Returns: String?
    public func content() -> String? {
        
        do {
            let filePath = Bundle(for: self.classForCoder).url(forResource: "PrefixTestFile", withExtension: "swift")
            if let filePath = filePath {
                print(filePath.absoluteString)
                return try String(contentsOf: filePath, encoding: String.Encoding.utf8)
            }
            
        } catch {
            print(error)
        }
        
        return nil
    }
}

class PrefixTestFile2{
}

/// Declaration protocol for PrefixTestFile
protocol PrefixTestFileProtocol {
}

protocol PrefixTestFileProtocol2: PrefixTestFileProtocol {
}

protocol PrefixTestFileProtocol3 : PrefixTestFileProtocol2 {
}

protocol prefixTestFileProtocol4 {
}

protocol prefixTestFileProtocol5{
}

extension prefixTestFileProtocol5 {
}

class UIView {
}

class UIViewController {
}

extension UIView {
}

extension UIViewController {
}

