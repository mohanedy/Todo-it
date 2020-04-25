//
//  SwipeCellViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/25/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import  SwipeCellKit
class SwipeCellViewController: UIViewController, SwipeTableViewCellDelegate {
    
    func deleteCell(at indexPath:IndexPath){
        print("Deleted")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.deleteCell(at: indexPath)

        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}
