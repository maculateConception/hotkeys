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
    
//    static func fromKeyEvent(_ event: NSEvent) -> Shortcut {
//        
//    }
    
    func toString() -> String {
        
        var str: String = ""
        
        for mod in modifiers {
//            str = str + mod.rawValue
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
}

enum ActionType: String {
    
    case openFile = "Open File"
    case openFolder = "Open Folder"
    case openWebAddress = "Open Web Address"
    case launchApp = "Launch Application"
}
