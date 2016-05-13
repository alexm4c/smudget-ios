//
//  BudgetItemTableViewCell.swift
//  Smudget
//
//  Created by Alex Mc Bain on 6/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit

class BudgetItemTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var budgetItemName: UILabel!
    @IBOutlet weak var budgetItemAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}