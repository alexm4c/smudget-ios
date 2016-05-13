//
//  Budget.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit

class Budget {
    
    // MARK: Properties
    var title:String
    var incomes:[(name:String, amount:Double)]
    var expenses:[(name:String, amount:Double)]

    // MARK: Initialization
    init(title: String) {
        self.title = title
        self.incomes = [(name:String, amount:Double)]()
        self.expenses = [(name:String, amount:Double)]()
    }
}