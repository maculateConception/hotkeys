//
//  ActionExecutor.swift
//  HotKeys
//
//  Created by Kay Ven on 5/19/18.
//  Copyright © 2018 anon. All rights reserved.
//

import Cocoa

class ActionExecutor {
    
    static func execute(_ action: Action) {
        
        let arg = action.arg
        
        switch action.type {
            
        case .launchApp, .openFile, .openFolder:    openPath(arg)
            
        case .openWebAddress:                       openURL(arg)
            
        }
    }
    
    private static func openPath(_ path: String) {
        NSWorkspace.shared().openFile(path)
    }
    
    private static func openURL(_ url: String) {
        NSWorkspace.shared().open(URL(string: url)!)
    }
}
