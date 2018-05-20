//
//  MapperWindowController.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class MapperWindowController: NSWindowController {
    
    private var addMapppingDialogController: AddMappingDialogController = AddMappingDialogController()
    
    @IBOutlet weak var mapperView: NSTableView!
    
    @IBAction func addMapping(_ sender: Any) {
        
        let dialog = addMapppingDialogController.window!
        NSApp.runModal(for: dialog)
        dialog.close()
        
        mapperView.reloadData()
    }
    
    private var theWindow: NSWindow {
        return self.window!
    }
    
    override var windowNibName: String? {return "MapperWindow"}
}
