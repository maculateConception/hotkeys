//
//  AppDelegate.swift
//  HotKeys
//
//  Created by Kay Ven on 5/18/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        print("Did Finish !")
        
        // Set up an input handler to handle scrolling and type selection with key events and gestures
        NSEvent.addLocalMonitorForEvents(matching: [.keyDown], handler: {(event: NSEvent!) -> NSEvent in
            
            KeyHandler.handle(event)
            return event;
        });
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

