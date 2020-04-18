//
//  ViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/14/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import BottomPopup
class TodoListViewController: UITableViewController, TodoDelegate {
  

    var dataSource = ["Mohaned","in da","House"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier,for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
   
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =  tableView.cellForRow(at: indexPath)
       
        if cell?.accessoryType == UITableViewCell.AccessoryType.none{
             cell?.accessoryType = .checkmark
        }else{
            cell?.accessoryType = .none
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item Methods
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: K.popUpVC) as? BottomSheetViewController else { return }
        popVC.popupDelegate = self
        popVC.delegate = self
        present(popVC, animated: false, completion: nil)
        
    }
    
    func todoItemIsAdded(text: String) {
        dataSource.append(text)
        tableView.reloadData()
      }
      
    
    
  

}
extension TodoListViewController: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}

