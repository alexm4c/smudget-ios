//
//  SampleBudgets.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import Foundation

class SampleBudgets {
    // MARK: Properties
    var budgets = [Budget]()
    
    
    init() {
        loadSampleBudgets()
    }

    func loadSampleBudgets() {
        let budget1 = Budget(title: "My First Budget");
        
        budget1.incomes.append(("YA", 270))
        budget1.incomes.append(("Work", 300))
        
        budget1.expenses.append(("Coffee", 40))
        budget1.expenses.append(("Myki", 40))
        budget1.expenses.append(("Food", 80))
        budget1.expenses.append(("Rent", 300))
        
        let budget2 = Budget(title: "Traveling");
        
        budget2.incomes.append(("Saved", 2000))
        
        budget2.expenses.append(("Flights", 1200))
        budget2.expenses.append(("Food", 200))
        budget2.expenses.append(("Accommidation", 600))
        
        
        budgets += [budget1, budget2]
    }
    
}

let sampleBudgets = SampleBudgets()