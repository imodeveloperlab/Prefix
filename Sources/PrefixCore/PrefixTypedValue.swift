//
//  PrefixTypedValue.swift
//  PrefixPackageDescription
//
//  Created by Borinschi Ivan on 4/23/18.
//

import Foundation

/// Typed value struct
public struct PrefixTypedValue<Tag, Type: Hashable>: Hashable {
    
    public var value: Type
    
    public init(_ value: Type) {
        self.value = value
    }
    
    public var hashValue: Int {
        return value.hashValue
    }
    
    public static func == (lhs: PrefixTypedValue, rhs: PrefixTypedValue) -> Bool {
        return lhs.value == rhs.value
    }
}
