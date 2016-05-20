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
    
    var id:Int

    // MARK: Initialization
    init() {
        self.title = "New Budget Title"
        self.incomes = [BudgetItem]()
        self.expenses = [BudgetItem]()
        self.currency = "AUD"
        self.id = 0
    }
    
    // Convenience functions for calculating totals
    func incomeTotal() -> Double {
        var total:Double = 0
        for income in incomes {
            total += income.value
        }
        return total
    }
    func expenseTotal() -> Double {
        var total:Double = 0
        for expense in expenses {
            total += expense.value
        }
        return total
    }
    func balanceTotal() -> Double {
        return incomeTotal() + expenseTotal()
    }
}