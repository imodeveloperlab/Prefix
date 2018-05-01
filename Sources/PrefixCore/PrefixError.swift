//
//  PrefixError.swift
//  PrefixCore
//
//  Created by Borinschi Ivan on 5/1/18.
//

import Foundation

public enum PrefixError: Error {
    
    case `default`(message: String)
    
    public init(message: String) {
        self = .`default`(message: message)
    }
}
