//
//  ViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/14/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
class TodoListViewController: UITableViewController, TodoDelegate {
  
    let data = UserDefaults.standard

    var dataSource:[TodoItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if let  safeData = data.object(forKey: K.dataKey){
            let decodedItems = NSKeyedUnarchiver.unarchivedObject(ofClass: TodoItem, from: safeData)
            dataSource = decodedItems
        }
        
    }
    
    //MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier,for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].text
   
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =  tableView.cellForRow(at: indexPath)
       
        if dataSource[indexPath.row].isChecked{
             cell?.accessoryType = .checkmark
        }else{
            cell?.accessoryType = .none
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item Methods
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: K.popUpVC) as? BottomSheetViewController else { return }
        popVC.delegate = self
        present(popVC, animated: false, completion: nil)
        
    }
    
    func todoItemIsAdded(item: TodoItem) {
        do{
        dataSource.append(item)
        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: dataSource, requiringSecureCoding: false)
        data.set(encodedData, forKey: K.dataKey)
        tableView.reloadData()
        }catch{
            print(error)
        }
        }
      
    
    
  

}

