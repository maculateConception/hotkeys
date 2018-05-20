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
    
    @IBOutlet weak var actionTypeMenu: NSPopUpButton!
    
    @IBOutlet weak var actionArgumentField: NSTextField!
    
    @IBAction func actionTypeChanged(_ sender: Any) {
        shortcutField.lostFocus()
    }
    
    private var theWindow: NSWindow {
        return self.window!
    }
    
    override var windowNibName: String? {return "AddMappingDialog"}
    
    @IBAction func saveAction(_ sender: Any) {
        
        let shc = shortcutField.shortcut
        let actionType = getActionType()
        let actionArg = actionArgumentField.stringValue
        let action = Action(actionType, actionArg)
        
        let mapping = Mapping(shc!, action)
        
        ProfileContext.addMapping(mapping)
        NSApp.stopModal()
    }
    
    private func getActionType() -> ActionType {

        switch actionTypeMenu.selectedItem!.tag {
            
        case 0: return ActionType.launchApp
            
        case 1: return ActionType.openFile
            
        case 2: return ActionType.openFolder
            
        case 3: return ActionType.openWebAddress
            
        default: return ActionType.launchApp
            
        }
    }
 
    @IBAction func cancelAction(_ sender: Any) {
        NSApp.stopModal()
    }
}
