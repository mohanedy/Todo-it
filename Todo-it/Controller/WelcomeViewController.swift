//
//  WelcomeViewController.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/23/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefaults.bool(forKey: "isShown"){
            print("I am Here")
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: K.categorySegue, sender: self)
                
            }
            
        }
        
    }
    
    
    
    @IBAction func getStartedPressed(_ sender: UIButton) {
        userDefaults.set(true, forKey: "isShown" )
        performSegue(withIdentifier: K.categorySegue, sender: self)
    }
    
    
    
    
}
