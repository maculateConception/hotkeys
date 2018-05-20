import Cocoa

/*
 Data source for the NSTableView that displays the "Tracks" (flat) playlist view.
 */
class ProfileViewDataSource: NSObject, NSTableViewDataSource, NSTableViewDelegate {
    
    // Returns the total number of playlist rows
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ProfileContext.profile.numMappings
    }
    
    // Returns a view for a single column
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let mapping = ProfileContext.profile.mappings[row]
            
        switch tableColumn!.identifier {
            
        case "m_shortcut":
            
            // Otherwise, create a text cell with the track index
            return createShortcutCell(tableView, mapping.shortcut)
            
        case "m_actionType":
            
            // Track name
            return createActionTypeCell(tableView, mapping.action)
            
        case "m_actionArgument":
            
            // Duration
            return createActionArgumentCell(tableView, mapping.action)
            
        default: return nil
            
        }
    }
    
    private func createShortcutCell(_ tableView: NSTableView, _ shortcut: Shortcut) -> NSTableCellView? {
        
        return createTextCell(tableView, "m_shortcut", shortcut.toString())
    }
    
    private func createActionTypeCell(_ tableView: NSTableView, _ action: Action) -> NSTableCellView? {
        
        return createTextCell(tableView, "m_actionType", action.type.rawValue)
    }
    
    private func createActionArgumentCell(_ tableView: NSTableView, _ action: Action) -> NSTableCellView? {
        
        return createTextCell(tableView, "m_actionArgument", action.arg)
    }
    
    // Creates a cell view containing text
    private func createTextCell(_ tableView: NSTableView, _ id: String, _ text: String) -> NSTableCellView? {
        
        if let cell = tableView.make(withIdentifier: id, owner: nil) as? NSTableCellView {
            
            cell.textField?.stringValue = text
            return cell
        }
        
        return nil
}
}
