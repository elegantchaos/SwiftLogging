//
//  ConsoleHandler.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Foundation

public class ConsoleHandler: Handler {
    override public func log<T>(object: T, channel : Channel, context: Context) {
        if enabled {
            let prefix = ContextFormatter.prefix(channel, context: context)
            let suffix = ContextFormatter.suffix(channel, context: context)
            println("\(prefix)\(object)\(suffix)")
        }
    }
}
