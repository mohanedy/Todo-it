//
//  CategoryTableViewCell.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/22/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import MaterialComponents
class CategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cardView: MDCCardCollectionCell!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    var categoryItem:TodoCategory?{
        didSet{
            setCategory()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.clipsToBounds = true

        circleView.layer.borderColor = UIColor.red.cgColor
        circleView.layer.borderWidth = 5.0
 
         cardView.cornerRadius = 8
        cardView.setShadowElevation(ShadowElevation(rawValue: 10), for: .selected)
         cardView.setShadowColor(UIColor.black, for: .highlighted)
    }
    func setCategory() {
        categoryLabel.text = categoryItem?.name
        circleView.layer.borderColor = categoryItem?.color?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
