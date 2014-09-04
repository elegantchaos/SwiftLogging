//
//  SwiftLoggingTests.swift
//  SwiftLoggingTests
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Cocoa
import XCTest
import SwiftLogging

let testChannel = Channel(name:"test")

class SwiftLoggingTests: XCTestCase {

    var funcCalled : Bool = false

    func calculatedValue() -> Int {
        self.funcCalled = true;
        return 123;
    }

    func testExample() {
        let channel = Channel(name:"local")

        channel.log("this is a test")
        channel.log(1)
        channel.log(1.234)
        channel.log((1,2))
        channel.log([1,2])
        
        let x = 1
        let y = 1.23
        channel.log("a formatted test x is \(x), y is \(y)")

        testChannel.log("hello")

        channel.enabled = false
        channel.log("this shouldn't be logged \(self.calculatedValue())")
        channel.log(23 * self.calculatedValue())

        XCTAssertFalse(self.funcCalled, "shouldn't evaluate expression for disabled channel")
    }
    
}
