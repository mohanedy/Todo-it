//
//  TodoViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/23/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import CoreData
class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var dataSource:[TodoItem] = []
      var selectedCategory:TodoCategory?
              
       
      
      
      override func viewDidLoad() {
          super.viewDidLoad()
        loadData(predicate: nil)
        titleLabel.text = "\(selectedCategory!.name!)"
        
          let notificationCenter = NotificationCenter.default
           notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: context)
      }
      
    //MARK: - This method listen for changes in the CoreData context
      @objc func managedObjectContextObjectsDidChange(notification: NSNotification){
    itemsCountLabel.text = "You have \(dataSource.count) tasks"
    }
      
    
      //MARK: - TableViewDataSource
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return dataSource.count
      }
      
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier,for: indexPath)
          let item = dataSource[indexPath.row]
          cell.textLabel?.text = item.text
          cell.accessoryType =  item.isDone ? .checkmark : .none
          
          
          return cell
      }
      
      //MARK: - TableView Delegate Methods
      
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
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
      
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
      
      func loadData(with request:NSFetchRequest<TodoItem> = TodoItem.fetchRequest(),predicate:NSPredicate? = nil) {
          let categoryPredicate = NSPredicate(format: "\(K.CoreData.parentRelation).name MATCHES %@", selectedCategory!.name!)
          if let safePredicate = predicate {
              let compoundPredicates = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,safePredicate])
              request.predicate = compoundPredicates
          }else{
              request.predicate = categoryPredicate
          }
          
          do{
              
              dataSource =  try context.fetch(request)
          }catch{
              print("Error Fetching the data \(error)")
          }
          tableView.reloadData()
        itemsCountLabel.text = "You have \(dataSource.count) tasks"

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
        let request:NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        if (searchText != ""){
            let predicate =  NSPredicate(format: "text CONTAINS[cd] %@", searchText)
            loadData(with: request,predicate: predicate)
        }else{
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            loadData()
        }
        
        
    }
}


//MARK: - TodoDelegate

extension TodoViewController : BottomSheetDelegate{
    
    func itemIsAdded(text: String) {
        
        let item = TodoItem(context: context)
        item.text = text
        item.parentCategory =  selectedCategory!
        dataSource.append(item)
        saveData()
    }
}
