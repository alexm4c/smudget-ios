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
    var currency:String
    
    // Persistancy Attribute
    var id:Int

    // MARK: Initialization
    init() {
        self.title = "New Budget Title"
        self.incomes = [BudgetItem]()
        self.expenses = [BudgetItem]()
        self.currency = "AUD"
        self.id = 0
    }
    
    func calculateBalance() -> Double {
        
        var balance:Double = 0
        
        for income in incomes {
            balance += income.value
        }
        
        for expense in expenses {
            balance -= expense.value
        }
        
        return balance
    }
}