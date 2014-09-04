//
//  ConsoleHandler.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Foundation

public class ConsoleHandler: Handler {
    var enabled = true

    public func log(object: AnyObject, channel : Channel, context: Context) {
        if enabled {
            let text = object.description
            let prefix = ContextFormatter.prefix(channel, context: context)
            let suffix = ContextFormatter.suffix(channel, context: context)
            println("\(prefix)\(text)\(suffix)")
        }
    }

    public func enable() {
        enabled = true
    }

    public func disable() {
        enabled = false
    }

    public func description() -> String {
        return "Console"
    }

}
