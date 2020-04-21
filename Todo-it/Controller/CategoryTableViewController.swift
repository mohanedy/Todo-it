//
//  CategoryTableViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/20/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import CoreData
class CategoryTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryList:[TodoCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
    }
    
    
    //MARK: - Table Delegate Tables
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = categoryList[indexPath.row].name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.itemsListSegue, sender: self)
        
    }
    
    @IBAction func onAddCategoryPressed(_ sender: UIButton) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: K.popUpVC) as? BottomSheetViewController else { return }
        popVC.type = .category
        popVC.delegate = self
        present(popVC, animated: false, completion: nil)
    }
    
    
    //MARK: - Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.itemsListSegue{
            let destinationVC = segue.destination as! TodoListViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.selectedCategory = categoryList[indexPath.row]
            }
            
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
    
    func loadData(with request : NSFetchRequest<TodoCategory> = TodoCategory.fetchRequest()) {
        do{
            
            categoryList =  try context.fetch(request)
        }catch{
            print("Error Fetching the data \(error)")
        }
        tableView.reloadData()
    }
    
}

extension CategoryTableViewController :  BottomSheetDelegate{
    func itemIsAdded(text: String) {
        let category = TodoCategory(context: context)
        category.name = text
        categoryList.append(category)
        saveData()
        
    }
    
    
}
