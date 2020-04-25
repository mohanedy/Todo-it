//
//  CategoryTableViewCell.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/22/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwipeCellKit
class CategoryTableViewCell: SwipeTableViewCell {

    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    var categoryItem:TodoCategory?{
        didSet{
            setCategory()
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.clipsToBounds = true

        circleView.layer.borderColor = UIColor.red.cgColor
        circleView.layer.borderWidth = 5.0
        
        
        //MARK: - This Will Give the shape of the card
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = false
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.borderWidth = 0.2
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 5, height: 5);
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowRadius = 5
    }
    func setCategory() {
      
            categoryLabel.text = categoryItem?.name
        circleView.layer.borderColor = UIColor(hexString: categoryItem?.color ?? "#FFCC00DD")?.cgColor
        subtitleLabel.text = "You have \(categoryItem?.todoItems.count ?? 0) tasks"
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
