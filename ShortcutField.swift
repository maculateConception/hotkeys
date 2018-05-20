//
//  ShortcutField.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class ShortcutField: NSTextField {
    
    var shortcut: Shortcut?
    
    override func viewDidMoveToWindow() {
        
        NSEvent.addLocalMonitorForEvents(matching: [.keyDown], handler: {(event: NSEvent!) -> NSEvent in
            
            if (self.stringValue == "<Type Shortcut>") {
            
                let shortcut = Shortcut.fromKeyEvent(event)
                self.stringValue = shortcut.toString()
                self.shortcut = shortcut
            }
            
            return event;
        });
    }
    
    override func mouseDown(with event: NSEvent) {
        self.stringValue = "<Type Shortcut>"
    }
    
    func lostFocus() {
        if (self.stringValue == "<Type Shortcut>") {
            self.stringValue = ""
        }
    }
    
    func reset() {
        self.stringValue = ""
        self.shortcut = nil
    }
}
