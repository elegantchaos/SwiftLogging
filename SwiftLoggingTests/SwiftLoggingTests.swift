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

func logFromFunc() {
    testChannel.log("hello from a global function")
}

func debugFromFunc() {
    testChannel.debug("hello from a global function")
}

class SwiftLoggingTests: XCTestCase {

    var funcCalled : Bool = false

    override func setUp() {
        let bundle = NSBundle(forClass:self.dynamicType)
        LogManager.defaultManager().registerHandlersFromBundle(bundle)
    }
    
    func calculatedValue() -> Int {
        self.funcCalled = true;
        return 123;
    }

    func testLog() {
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

        logFromFunc()

        channel.enabled = false
        channel.log("this shouldn't be logged \(self.calculatedValue())")
        channel.log(23 * self.calculatedValue())

        
        XCTAssertFalse(self.funcCalled, "shouldn't evaluate expression for disabled channel")
    }

    func testDebug() {
        let channel = Channel(name:"debug")
        
        channel.debug("this is a test")
        channel.debug(1)
        channel.debug(1.234)
        channel.debug((1,2))
        channel.debug([1,2])
        
        let x = 1
        let y = 1.23
        channel.debug("a formatted test x is \(x), y is \(y)")
        
        testChannel.debug("hello")
        
        debugFromFunc()
        
        channel.enabled = false
        channel.debug("this shouldn't be logged \(self.calculatedValue())")
        channel.debug(23 * self.calculatedValue())
        
        
        XCTAssertFalse(self.funcCalled, "shouldn't evaluate expression for disabled channel")
    }

}
