//
//  LogManager.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Cocoa

public let defaultManager = LogManager()

public class LogManager {

    var handlers : [Handler] = []

    init() {
        let bundle = NSBundle(forClass:self.dynamicType)
        registerHandlersFromBundle(bundle)
        self.handlers.append(ConsoleHandler(name:"Console"))
    }
    
    public func registerChannel(channel : Channel) -> () {
        // TODO: read settings and use them to set up handlers, and configure the channel
        channel.handlers = self.handlers
    }
    
    public func registerHandlersFromBundle(bundle : NSBundle) {
        let fm = NSFileManager.defaultManager()
        let folder = bundle.builtInPlugInsURL
        var error : NSError?
        if let handlerURLs = fm.contentsOfDirectoryAtURL(folder!, includingPropertiesForKeys:[], options:NSDirectoryEnumerationOptions(0), error:&error) {
            for url in handlerURLs {
                if (url.pathExtension == "loghandler") {
                    registerHandlerPluginAtURL(url as NSURL)
                }
            }
        }
    }
    
    func registerHandlerPluginAtURL(url : NSURL) {
        let bundle = NSBundle(URL: url)
        if let handlerClass : AnyClass = bundle.principalClass {
            let instance = (handlerClass as Handler.Type)(name:"Bundle") as Handler
            self.handlers.append(instance)
        }
    }
}
