//
//  ShortcutField.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class ShortcutField: NSTextField {
    
    override func mouseDown(with event: NSEvent) {
        Swift.print("Clicked text field")
        self.becomeFirstResponder()
    }
}

