//
//  CategoryViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/22/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryList:[TodoCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: context)
       
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.categoryCellIdentifier)
    }
    
    //MARK: - This method listen for changes in the CoreData context
    @objc func managedObjectContextObjectsDidChange(notification: NSNotification){
       numberLabel.text = "You have \(categoryList.count) categories"
    }
    

    //MARK: - Table Delegate Tables
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier, for: indexPath) as! CategoryTableViewCell
        
        cell.categoryItem = categoryList[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            let destinationVC = segue.destination as! TodoViewController
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
        numberLabel.text = "You have \(categoryList.count) categories"
    }
    
}
extension CategoryViewController :  BottomSheetDelegate{
    func itemIsAdded(text: String) {
        let category = TodoCategory(context: context)
        category.name = text
        category.color = UIColor.random
        categoryList.append(category)
        saveData()
        
    }
    
    
}
