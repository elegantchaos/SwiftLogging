//
//  Handler.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Cocoa

public class Handler {
    
    public var enabled : Bool = true
    public var name : String
    
    public required init(name : String) {
        self.name = name
    }
    
    public func log<T>(object: T, channel : Channel, context: Context) {
    }
}
