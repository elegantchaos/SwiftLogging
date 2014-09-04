//
//  Context.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Cocoa

public class Context {
    let file: String
    let line : Int
    let function : String
    let column : Int

    public init(file: String = __FILE__, line: Int = __LINE__,  column: Int = __COLUMN__, function: String = __FUNCTION__) {
        self.file = file
        self.line = line
        self.function = function
        self.column = column
    }

}
