//
//  Constants.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/17/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
struct K {
    static let cellIdentifier = "ToDoItemCell"
    static let popUpVC = "PopUpVC"
    static let dataKey = "todoListItems"
    static let categoryCellIdentifier = "CategoryCell"
    static let itemsListSegue = "itemsListSegue"
    static let cellNibName = "CategoryTableViewCell"
    static let categorySegue = "CategorySegue"
    
    struct CoreData {
        static let parentRelation = "parentCategory"
    }
}
