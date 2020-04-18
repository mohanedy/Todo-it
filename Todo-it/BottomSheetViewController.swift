//
//  BottomSheetViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/18/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import BottomPopup

class BottomSheetViewController: BottomPopupViewController{
    
    @IBOutlet weak var todoTextField: UITextField!
    var delegate:TodoDelegate?
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // Bottom popup attribute variables
    // You can override the desired variable to change appearance
    
    override var popupHeight: CGFloat { CGFloat(300) }
    
    override var popupTopCornerRadius: CGFloat { return CGFloat(10) }
    
    override var popupPresentDuration: Double { return  1.0 }
    
    override var popupDismissDuration: Double { return 1.0 }
    
    override var popupShouldDismissInteractivelty: Bool {
        
        return true
    }
    
    @IBAction func onAddPressed(_ sender: UIButton) {
        if todoTextField.text != "" {
            delegate?.todoItemIsAdded(text: todoTextField.text!)
            todoTextField.text = ""
                dismiss(animated: true, completion: nil)
        }
        
    }
    
}
//MARK: - This Protocol to pass data back

protocol TodoDelegate {
    func todoItemIsAdded(text:String)
}
