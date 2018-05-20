//
//  ProfileContext.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class ProfileContext {
    
    static let profile: Profile = Profile()
    
    static func addMapping(_ mapping: Mapping) {
        profile.addMapping(mapping)
    }
    
    static func getActionForShortcut(_ shortcut: Shortcut) -> Action? {
        return profile.getActionForShortcut(shortcut)
    }
}
