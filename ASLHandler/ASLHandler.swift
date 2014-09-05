//
//  ASLHandler.swift
//  SwiftLogging
//
//  Created by Sam Deane on 05/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import SwiftLogging

public class ASLHandler : SwiftLogging.ConsoleHandler {
    override public func log<T>(object: T, channel : Channel, context: Context) {
        if enabled {
            println("ASL:\(object)")
        }
    }

}
