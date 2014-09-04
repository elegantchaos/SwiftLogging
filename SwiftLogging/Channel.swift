//
//  LogChannel.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Cocoa

public class Channel {

    let name: String
    var handlers: [Handler]
    var enabled: Bool;

    public init(name: String) {

            self.name = name
            self.handlers = [Handler]()
            self.handlers.append(ConsoleHandler())
            self.enabled = true;

            defaultManager.registerChannel(self);
    }


    public func log(
        message: @autoclosure() -> AnyObject,
        context: Context = Context()) {
            if (self.enabled) {
                let object : AnyObject = message()
                for handler in handlers {
                    handler.log(object, context:context)
                }
            }
}

}
//    func log(logMessage: String, functionName: String = __FUNCTION__) {
//    println("\(functionName): \(logMessage)")
//    }
//
//    __FILE__ String The name of the file in which it appears.
//
//    __LINE__ Int The line number on which it appears.
//
//    __COLUMN__ Int The column number in which it begins.
//
//    __FUNCTION__ String The name of the declaration in which it appears.
//    

// https://github.com/hubertr/Swell
