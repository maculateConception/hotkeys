//
//  KeyHandler.swift
//  HotKeys
//
//  Created by Kay Ven on 5/18/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class KeyHandler {
    
    static func handle(_ event: NSEvent) {
        
        // Indicate whether or not Shift/Command/Option were pressed
        let isShift: Bool = event.modifierFlags.contains(NSEventModifierFlags.shift)
        let isCommand: Bool = event.modifierFlags.contains(NSEventModifierFlags.command)
        let isOption: Bool = event.modifierFlags.contains(NSEventModifierFlags.option)
        let isCtrl: Bool = event.modifierFlags.contains(NSEventModifierFlags.control)
        
//        let isArrow: Bool = KeyCodeConstants.arrows.contains(event.keyCode)
        
        let chars = event.charactersIgnoringModifiers
        
        print("This is: " + chars! + "\n")
//        print("This is: " + String(event.modifierFlags))
        
        if (isOption && chars == "1") {
            NSWorkspace.shared().open(URL(fileURLWithPath: "/Applications/Preview.app"))
        }
        
        if (isOption && chars == "2") {
            let url = URL(string: "https://en.wikipedia.org")!
            NSWorkspace.shared().open(url)
        }
        
        if (isOption && chars == "3") {
            NSWorkspace.shared().openFile("/Users/kven/Documents/Sean.rtf")
        }
        
        if (isOption && chars == "4") {
            NSWorkspace.shared().openFile("/Users/kven/Movies")
        }
        
        if (isCtrl && chars?.uppercased() == "D") {
            NSWorkspace.shared().openFile("/Users/kven/SSHD/Svd/0x")
        }
    }
}
