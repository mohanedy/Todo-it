//
//  TodoViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/23/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework
class TodoViewController: SwipeCellViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var itemsResults: Results<TodoItem>?
    var selectedCategory:TodoCategory?
    let realm = try! Realm()
    var token:NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "\(selectedCategory?.name ?? "")"
        loadData()
        token = itemsResults?.observe({ (change) in
            self.itemsCountLabel.text = "You have \(self.itemsResults?.count ?? 0) tasks"
            self.tableView.reloadData()
        })
        tableView.rowHeight = 80.0
        
    }
    deinit {
        token?.invalidate()
    }
    
    //MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsResults?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier,for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        if let item = itemsResults?[indexPath.row]{
            
            cell.textLabel?.text = item.text
            
            cell.accessoryType =  item.isDone ? .checkmark : .none
            cell.textLabel?.textColor = .white
//            let formater = DateFormatter()
//            formater.dateFormat = "dd/MM/yy HH:mm"
//            let date =  formater.string(from: item.creationDate)
//            cell.detailTextLabel?.text = date
            
            let categoryColor = UIColor(hexString: selectedCategory!.color)
            if let bgColor = categoryColor?.darken(byPercentage: CGFloat(indexPath.row)/CGFloat(itemsResults!.count)){
                cell.backgroundColor = bgColor
                cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: bgColor, isFlat: true)
                cell.accessoryView?.tintColor = UIColor(contrastingBlackOrWhiteColorOn: bgColor, isFlat: true)
            }
            
            
            
        }else{
            cell.textLabel?.text = "No Items Available"
        }
        
        
        return cell
    }
    
    
    //MARK: - Delete Functionality
    
    override func deleteCell(at indexPath:IndexPath){
        if let item = self.itemsResults?[indexPath.row]{
            do {
                try self.realm.write{
                    self.realm.delete(item)
                }
            } catch  {
                print(error)
            }
            
        }
    }
    
    
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemsResults?[indexPath.row]{
            do {
                try realm.write{
                    item.isDone = !item.isDone
                }
            } catch {
                print(error)
            }
            
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item Methods
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: K.popUpVC) as? BottomSheetViewController else { return }
        popVC.delegate = self
        present(popVC, animated: false, completion: nil)
        
    }
    
    
    
    
    
    //MARK: - Load data from core data
    
    func loadData() {
        itemsResults = selectedCategory?.todoItems.sorted(byKeyPath: "creationDate", ascending: true)
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
        
        if (searchText != ""){
            let predicate =  NSPredicate(format: "text CONTAINS[cd] %@", searchText)
            itemsResults = itemsResults?.filter(predicate).sorted(byKeyPath: "creationDate", ascending: true)
            
        }else{
            itemsResults = selectedCategory?.todoItems.sorted(byKeyPath: "creationDate", ascending: true)
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        tableView.reloadData()
        
        
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
        }
    }
}

