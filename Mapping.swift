//
//  Mapping.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class Mapping {
    
    var shortcut: Shortcut
    var action: Action
    
    init(_ shortcut: Shortcut, _ action: Action) {
        self.shortcut = shortcut
        self.action = action
    }
}

class Shortcut {
    
    var modifiers: Set<Modifier> = []
    var chars: String = ""
}

enum Modifier {
    
    case shift
    case ctrl
    case option
    case cmd
}

enum Action {
    
    case openFile
    case openFolder
    case openWebAddress
    case launchApp
}
