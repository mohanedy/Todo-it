//
//  ViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/14/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dataSource:[TodoItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
    }
    
    //MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier,for: indexPath)
        let item = dataSource[indexPath.row]
        cell.textLabel?.text = item.text
        cell.accessoryType =  item.isDone ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataSource[indexPath.row].isDone = !dataSource[indexPath.row].isDone
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item Methods
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: K.popUpVC) as? BottomSheetViewController else { return }
        popVC.delegate = self
        present(popVC, animated: false, completion: nil)
        
    }
    
    
    //MARK: - Swipe to delete
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(dataSource[indexPath.row])
            dataSource.remove(at: indexPath.row)
            saveData()
        }
    }
    
    
    //MARK: - Saves data to the CoreData
    func saveData(){
        do{
            
            try context.save()
            
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    //MARK: - Load data from core data

    func loadData(with request:NSFetchRequest<TodoItem> = TodoItem.fetchRequest()) {
        do{
            
            dataSource =  try context.fetch(request)
        }catch{
            print("Error Fetching the data \(error)")
        }
          tableView.reloadData()
    }
    
}

//MARK: - Search Bar Delegate Methods
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let request:NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        if (searchText != ""){
            request.predicate =  NSPredicate(format: "text CONTAINS[cd] %@", searchText)
            
        }else{
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
        }
        loadData(with: request)
      
    }
}


//MARK: - TodoDelegate

extension TodoListViewController : BottomSheetDelegate{
    
    func itemIsAdded(text: String) {

        let item = TodoItem(context: context)
        item.text = text
        dataSource.append(item)
        saveData()
    }
}
