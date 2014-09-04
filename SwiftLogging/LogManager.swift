//
//  LogManager.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Cocoa

let defaultManager = LogManager()

public class LogManager {

    public func registerChannel(channel : Channel) -> () {
        // TODO: read settings and use them to set up handlers, and configure the channel
        channel.addHandler(ConsoleHandler())
    }
}
