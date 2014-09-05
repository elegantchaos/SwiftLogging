//
//  LogManager.swift
//  SwiftLogging
//
//  Created by Sam Deane on 04/09/2014.
//  Copyright (c) 2014 Elegant Chaos. All rights reserved.
//

import Cocoa

private let defaultInstance = LogManager()

public class LogManager {

    var handlers : [Handler] = []
    lazy var settings : NSDictionary = NSDictionary()
    
    public class func defaultManager() -> (LogManager) {
        return defaultInstance
    }

    init() {
        let bundle = NSBundle(forClass:self.dynamicType)
        registerHandlersFromBundle(bundle)
        handlers.append(ConsoleHandler(name:"Console"))
        loadSettings()
    }
    
    public func registerChannel(channel : Channel) -> () {
        // TODO: read settings and use them to set up handlers, and configure the channel
        channel.handlers = handlers
    }
    
    public func registerHandlersFromBundle(bundle : NSBundle) {
        if let folder = bundle.builtInPlugInsURL {
            registerHandlersInFolder(folder)
        } else {
            internalLog("failed to get plugins folder from bundle \(bundle)")
        }
    }
    
    public func registerHandlersInFolder(folder : NSURL) {
        let fm = NSFileManager.defaultManager()
        var error : NSError?
        if let handlerURLs = fm.contentsOfDirectoryAtURL(folder, includingPropertiesForKeys:[NSURLPathKey], options:NSDirectoryEnumerationOptions(0), error:&error) {
            for url in handlerURLs {
                if (url.pathExtension == "loghandler") {
                    registerHandlerPluginAtURL(url as NSURL)
                }
            }
        } else if let actualError = error {
            if (actualError.domain != NSCocoaErrorDomain) || (actualError.code != NSFileReadNoSuchFileError) {
                internalLog("failed to register handlers in folder \(folder), error: \(error)")
            }
        }
    }

    func registerHandlerPluginAtURL(url : NSURL) {
        let bundle = NSBundle(URL: url)
        if let handlerClass : AnyClass = bundle.principalClass {
            let instance = (handlerClass as Handler.Type)(name:"Bundle") as Handler
            handlers.append(instance)
        } else {
            internalLog("failed to load handler plugin from \(url)")
        }
    }
    
    func internalLog(message : @autoclosure () -> String) {
        println(message())
    }
    
    func loadSettings() -> (NSDictionary) {
        var settings = loadSettingsForBundle(NSBundle.mainBundle())
        if (settings == nil) {
            let bundle = NSBundle(forClass:self.dynamicType)
            settings = loadSettingsForBundle(bundle)
        }
        
        if (settings == nil) {
            settings = NSDictionary()
        }
        
        return settings!
    }
    
    func settingsKeys() -> [String] {
        #if DEBUG
            let keys = ["ECLoggingDebug", "ECLogging"]
        #else
            let keys = ["ECLogging"]
        #endif
        
        return keys
    }
    
    func loadSettingsForBundle(bundle : NSBundle) -> (NSDictionary?) {
        var result : NSDictionary?
        let info = bundle.infoDictionary
        for key in settingsKeys() {
            result = info[key] as? NSDictionary
            if (result == nil) {
                if let url = bundle.URLForResource(key, withExtension: "plist") {
                    result = NSDictionary(contentsOfURL: url)
                    if (result != nil) {
                        internalLog("loaded settings")
                        break;
                    }
                }
            }
        }
        
        return result
    }
}
