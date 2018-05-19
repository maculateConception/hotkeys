//
//  MapperWindowController.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class MapperWindowController: NSWindowController {
    
    @IBAction func addMapping(_ sender: Any) {
        
        let mods: Set<Modifier> = [Modifier.cmd]
        let chars = "F"
        
        let sht = Shortcut(mods, chars)
        let act = Action(ActionType.openWebAddress, "en.wikipedia.org")
        
        let map = Mapping(sht, act)
        ProfileContext.addMapping(map)
    }
    
    private var theWindow: NSWindow {
        return self.window!
    }
    
    override var windowNibName: String? {return "MapperWindow"}
    
    override func windowDidLoad() {
        
        print("Loaded Mapper Window !")
    }
}
