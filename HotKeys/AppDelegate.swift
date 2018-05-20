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
    
    let mwc = MapperWindowController()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        NSEvent.addLocalMonitorForEvents(matching: [.keyDown], handler: {(event: NSEvent!) -> NSEvent in
            
            KeyHandler.handle(event)
            return event;
        });
        
        mwc.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
