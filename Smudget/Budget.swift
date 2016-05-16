//
//  Budget.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import Foundation

class Budget {
    
    struct BudgetItem {
        var name:String
        var value:Double
    }
    
    // MARK: Properties
    var title:String
    var incomes:[BudgetItem]
    var expenses:[BudgetItem]

    // MARK: Initialization
    init() {
        self.title = "New Budget Title"
        self.incomes = [BudgetItem]()
        self.expenses = [BudgetItem]()
    }
}