//
//  Handler.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Cocoa

public protocol Handler {
    func log<T>(object: T, channel : Channel, context: Context);

    func enable();
    func disable();

    func description() -> String
}
