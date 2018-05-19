import Cocoa

/*
 Data source for the NSTableView that displays the "Tracks" (flat) playlist view.
 */
class TracksPlaylistViewDataSource: NSObject, NSTableViewDataSource, NSTableViewDelegate {
    
    // Returns the total number of playlist rows
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ProfileContext.profile.mappings.count
    }
    
    // Returns a view for a single column
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let mapping = ProfileContext.profile.mappings[row] {
            
            switch tableColumn!.identifier {
                
            case "shortcut":
                
                
                    // Otherwise, create a text cell with the track index
                    return createTextCell(tableView, UIConstants.playlistIndexColumnID, String(format: "%d.", row + 1), row)
                
                
            case "action":
                
                // Track name
                return createTextCell(tableView, UIConstants.playlistNameColumnID, track.conciseDisplayName, row)
                
            case "argument":
                
                // Duration
                return createTextCell(tableView, UIConstants.playlistDurationColumnID, StringUtils.formatSecondsToHMS(track.duration), row)
                
            default: return nil
                
            }
        }
        
        return nil
    }
    
    // Creates a cell view containing text
    private func createTextCell(_ tableView: NSTableView, _ id: String, _ text: String, _ row: Int) -> NSTableCellView? {
        
        if let cell = tableView.make(withIdentifier: id, owner: nil) as? PlaylistCellView {
            
            cell.textField?.stringValue = text
            
            // Hide the image view and show the text view
            cell.imageView?.isHidden = true
            cell.textField?.isHidden = false
            
            cell.row = row
            
            return cell
        }
        
        return nil
}
}
