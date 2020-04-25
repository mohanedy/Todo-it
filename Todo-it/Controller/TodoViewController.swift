//
//  TodoViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/23/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import RealmSwift
class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var itemsResults: Results<TodoItem>?
    var selectedCategory:TodoCategory?
    let realm = try! Realm()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

                titleLabel.text = "\(selectedCategory?.name ?? "")"
        loadData()
        
        
    }
    
    
    //MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsResults?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier,for: indexPath)
        if let item = itemsResults?[indexPath.row]{
            cell.textLabel?.text = item.text
            cell.accessoryType =  item.isDone ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items Available"
        }
        
        
        
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        itemsResults?[indexPath.row].isDone = !(itemsResults?[indexPath.row].isDone ?? true)
        //        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item Methods
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: K.popUpVC) as? BottomSheetViewController else { return }
        popVC.delegate = self
        present(popVC, animated: false, completion: nil)
        
    }
    
    
    //MARK: - Swipe to delete
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //              context.delete(dataSource[indexPath.row])
            //            itemsResults.remove(at: indexPath.row)
            //            saveData()
        }
    }
    
    
    
    //MARK: - Load data from core data
    
    func loadData() {
        itemsResults = selectedCategory?.todoItems.sorted(byKeyPath: "text", ascending: true)
        tableView.reloadData()
        itemsCountLabel.text = "You have \(itemsResults?.count ?? 0) tasks"
        
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: - Search Bar Delegate Methods
extension TodoViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        //        if (searchText != ""){
        //            let predicate =  NSPredicate(format: "text CONTAINS[cd] %@", searchText)
        //            loadData(with: request,predicate: predicate)
        //        }else{
        //            DispatchQueue.main.async {
        //                searchBar.resignFirstResponder()
        //            }
        //            loadData()
        //        }
        
        
    }
}


//MARK: - TodoDelegate

extension TodoViewController : BottomSheetDelegate{
    
    func itemIsAdded(text: String) {
        if let safeCategory = selectedCategory{
            do{
                
                try realm.write{
                    let item = TodoItem()
                    item.text = text
                    safeCategory.todoItems.append(item)
                    
                }
                
            }catch{
                print(error)
            }
            tableView.reloadData()
        }
    }
}
