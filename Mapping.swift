//
//  Mapping.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class Profile {
    
    let name: String = "Default Profile"
    let file: String = "/path"
    var mappings: [Mapping] = []
    
    var numMappings: Int {
        return mappings.count
    }
    
    func addMapping(_ mapping: Mapping) {
        mappings.append(mapping)
    }
    
    func getActionForShortcut(_ target: Shortcut) -> Action? {
        
        for mapping in mappings {
            
            let shc = mapping.shortcut
            
            if (shc.equals(target)) {
                return mapping.action
            }
        }
        
        return nil
    }
}

class Mapping {
    
    var shortcut: Shortcut
    var action: Action
    
    init(_ shortcut: Shortcut, _ action: Action) {
        self.shortcut = shortcut
        self.action = action
    }
}

class Shortcut {
    
    var modifiers: Set<Modifier>
    var chars: String
    
    init(_ modifiers: Set<Modifier>, _ chars: String) {
        self.modifiers = modifiers
        self.chars = chars
    }
    
    func equals(_ other: Shortcut) -> Bool {
        
        if (self.chars != other.chars) {
            return false
        }
        
        if (self.modifiers.count != other.modifiers.count) {
            return false
        }
        
        for mod in self.modifiers {
            
            if (!other.modifiers.contains(mod)) {
                return false
            }
        }
        
        return true
    }
    
    static func fromKeyEvent(_ event: NSEvent) -> Shortcut {
        
        var mods = Set<Modifier>()
        
        // Indicate whether or not Shift/Command/Option were pressed
        let isShift: Bool = event.modifierFlags.contains(NSEventModifierFlags.shift)
        if (isShift) {
            mods.insert(Modifier.shift)
        }
        
        let isCommand: Bool = event.modifierFlags.contains(NSEventModifierFlags.command)
        if (isCommand) {
            mods.insert(Modifier.cmd)
        }
        
        let isOption: Bool = event.modifierFlags.contains(NSEventModifierFlags.option)
        if (isOption) {
            mods.insert(Modifier.option)
        }
        
        let isCtrl: Bool = event.modifierFlags.contains(NSEventModifierFlags.control)
        if (isCtrl) {
            mods.insert(Modifier.ctrl)
        }
        
        let chars = event.charactersIgnoringModifiers!.uppercased()
        
        return Shortcut(mods, chars)
    }
    
    func toString() -> String {
        
        var str: String = ""
        
        for mod in modifiers {
            str.append(mod.rawValue)
        }
        
        str.append(chars)
        
        return str
    }
}

enum Modifier: String {
    
    case shift = "⇧"
    case ctrl = "^"
    case option = "⌥"
    case cmd = "⌘"
}

class Action {
    
    let type: ActionType
    let arg: String
    
    init(_ type: ActionType, _ arg: String) {
        self.type = type
        self.arg = arg
    }
    
    func toString() -> String {
        return String(format: "%@: %@", type.rawValue, arg)
    }
}

enum ActionType: String {
    
    case openFile = "Open File"
    case openFolder = "Open Folder"
    case openWebAddress = "Open Web Address"
    case launchApp = "Launch Application"
}
