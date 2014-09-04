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

    // Use the static-inside-class-var approach to getting a class var instance
    class var instance: ConsoleHandler {
    struct Static {
        static let internalInstance = ConsoleHandler()
        }
        return Static.internalInstance
    }

    public class func getInstance() -> Handler {
        return instance
    }

    public func log(message: @autoclosure() -> String) {
        if enabled {
            println(message())
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
