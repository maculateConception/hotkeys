//
//  Mapping.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class Profile {
    
    var name: String = "Default Profile"
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
    
    func toSerializableMap() -> NSDictionary {
        
        var map = [NSString: AnyObject]()
        
        map["name"] = self.name as AnyObject
        
        var mappingsArr = [AnyObject]()
        
        for mapping in mappings {
            mappingsArr.append(mapping.toSerializableMap())
        }
        
        let mappingsNSArr = NSArray(array: mappingsArr)
        
        map["mappings"] = mappingsNSArr
        
        return map as NSDictionary
    }
    
    static func deserialize(_ map: NSDictionary) -> Profile {
        
        let profile = Profile()
        
        if let name = map["name"] as? String {
            profile.name = name
        }
        
        if let mappings = map["mappings"] as? [NSDictionary] {
            
            mappings.forEach({
                
                profile.mappings.append(Mapping.deserialize($0))
            })
        }
        
        return profile
    }
}

class Mapping {
    
    var shortcut: Shortcut
    var action: Action
    
    init(_ shortcut: Shortcut, _ action: Action) {
        self.shortcut = shortcut
        self.action = action
    }
    
    func toSerializableMap() -> NSDictionary {
        
        var map = [NSString: AnyObject]()
        
        map["shortcut"] = shortcut.toSerializableMap()
        map["action"] = action.toSerializableMap()
        
        return map as NSDictionary
    }
    
    static func deserialize(_ map: NSDictionary) -> Mapping {
        
        var shortcut: Shortcut?
        var action: Action?
        
        if let shortcutDict = map["shortcut"] as? NSDictionary {
            shortcut = Shortcut.deserialize(shortcutDict)
        }
        
        if let actionDict = map["action"] as? NSDictionary {
            action = Action.deserialize(actionDict)
        }
        
        return Mapping(shortcut!, action!)
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
    
    func toSerializableMap() -> NSDictionary {
        
        var map = [NSString: AnyObject]()
        
        var modsStrArr = [AnyObject]()
        for mod in self.modifiers {
            modsStrArr.append(mod.rawValue as AnyObject)
        }
        
        let modsArr = NSArray(array: modsStrArr)
        
        map["modifiers"] = modsArr
        map["chars"] = self.chars as AnyObject
        
        return map as NSDictionary
    }
    
    static func deserialize(_ map: NSDictionary) -> Shortcut {
        
        var mods: Set<Modifier> = []
        
        if let modsStrArr = map["modifiers"] as? [String] {
            modsStrArr.forEach {
                mods.insert(Modifier(rawValue: $0)!)
            }
        }
        
        var chars: String = ""
        
        if let charsStr = map["chars"] as? String {
            chars = charsStr
        }
        
        return Shortcut(mods, chars)
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
    
    func toSerializableMap() -> NSDictionary {
        
        var map = [NSString: AnyObject]()
        
        map["type"] = type.rawValue as AnyObject
        map["arg"] = arg as AnyObject
        
        return map as NSDictionary
    }
    
    static func deserialize(_ map: NSDictionary) -> Action {
        
        var type: ActionType?
        var arg: String = ""
        
        if let typeStr = map["type"] as? String {
            type = ActionType(rawValue: typeStr)
        }
        
        if let argStr = map["arg"] as? String {
            arg = argStr
        }
        
        return Action(type!, arg)
    }
}

enum ActionType: String {
    
    case openFile = "Open File"
    case openFolder = "Open Folder"
    case openWebAddress = "Open Web Address"
    case launchApp = "Launch Application"
}
