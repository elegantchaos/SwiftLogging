//
//  ContextFormatter.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Cocoa

class ContextFormatter {

    class func prefix(channel : Channel, context : Context) -> String {
        let result = (channel.showName) ? "\(channel.name): " : ""
        return result
    }

    class func suffix(channel : Channel, context : Context) -> String {
        let showSomething = channel.showFile || channel.showLineColumn || channel.showFunction
        var result = ""
        if (showSomething) {
            let function = channel.showFunction ? "\(context.function)" : ""
            let spacer1 = channel.showFunction && (channel.showFile || channel.showLineColumn) ? ", " : ""
            let file = channel.showFile ? "\(context.file)" : ""
            let spacer2 = (channel.showFile || channel.showFunction) && channel.showLineColumn ? ": " : ""
            let lineCol = channel.showLineColumn ? "\(context.line), \(context.column)" : ""
            result = " (\(function)\(spacer1)\(file)\(spacer2)\(lineCol))"
        }

        return result
    }

}
