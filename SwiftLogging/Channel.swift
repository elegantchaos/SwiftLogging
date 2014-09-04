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
    public var enabled: Bool;
    public var showName : Bool = true
    public var showFile : Bool = false
    public var showLineColumn : Bool = false
    public var showFunction : Bool = true

    public init(name: String) {

            self.name = name
            self.handlers = [Handler]()
            self.enabled = true;

            defaultManager.registerChannel(self);
    }


    public func addHandler(handler : Handler) {
        self.handlers.append(handler)
    }

    public func log(
        message: @autoclosure() -> AnyObject,
        file: String = __FILE__,
        line: Int = __LINE__,
        column: Int = __COLUMN__,
        function: String = __FUNCTION__) {
            if (self.enabled) {
                let object : AnyObject = message()
                let context = Context(file:file, line:line, column:column, function:function)
                for handler in handlers {
                    handler.log(object, channel:self, context:context)
                }
            }
}

}
// https://github.com/hubertr/Swell
