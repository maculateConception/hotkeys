//
//  AddMappingDialogController.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class AddMappingDialogController: NSWindowController {
    
    @IBOutlet weak var shortcutField: ShortcutField!
    
    private var theWindow: NSWindow {
        return self.window!
    }
    
    override var windowNibName: String? {return "AddMappingDialog"}
    
    override func windowDidLoad() {
        
        print("Loaded Add Mapping Window !")
        
        NSEvent.addLocalMonitorForEvents(matching: [.keyDown], handler: {(event: NSEvent!) -> NSEvent in
            
            
            KeyHandler.handle(event)
            return event;
        });
        
        theWindow.makeFirstResponder(shortcutField)
        shortcutField.cell?.showsFirstResponder = true
    }
    
    override func showWindow(_ sender: Any?) {
        
        print("\nShowing dialog")
        
        
        
        super.showWindow(sender)
    }
}
