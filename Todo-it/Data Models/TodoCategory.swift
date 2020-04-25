//
//  TodoCategory.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/24/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import RealmSwift

class TodoCategory: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let todoItems = List<TodoItem>()
}
