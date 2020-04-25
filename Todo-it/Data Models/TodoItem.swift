//
//  TodoItem.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/24/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var text: String = ""
    @objc dynamic var isDone: Bool = false
    let parentCategory = LinkingObjects(fromType: TodoCategory.self, property: "todoItems")
    
}
