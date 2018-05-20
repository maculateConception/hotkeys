//
//  ProfileContext.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class ProfileContext {
    
    static var profile: Profile = Profile()
    
    static func addMapping(_ mapping: Mapping) {
        profile.addMapping(mapping)
    }
    
    static func getActionForShortcut(_ shortcut: Shortcut) -> Action? {
        return profile.getActionForShortcut(shortcut)
    }
    
    static func load() {
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            
            let path = URL(fileURLWithPath: dir).appendingPathComponent("hotkeys-state.json")
            
            let inputStream = InputStream(url: path)
            inputStream?.open()
            
            do {
                let data = try JSONSerialization.jsonObject(with: inputStream!, options: JSONSerialization.ReadingOptions())
                
                inputStream?.close()
                
                profile = Profile.deserialize(data as! NSDictionary)
                
            } catch let error as NSError {
                NSLog("Error loading app state config file: %@", error.description)
            }
        }
    }
    
    static func save() {
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            
            let path = URL(fileURLWithPath: dir).appendingPathComponent("hotkeys-state.json")
            
            let outputStream = OutputStream(url: path, append: false)
            outputStream?.open()
            
            JSONSerialization.writeJSONObject(profile.toSerializableMap(), to: outputStream!, options: JSONSerialization.WritingOptions.prettyPrinted, error: nil)
            
            outputStream?.close()
        }
    }
}
