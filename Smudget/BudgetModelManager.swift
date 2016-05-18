//
//  BudgetModel.swift
//  Smudget
//
//  Created by Alex McBain on 14/05/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit
import CoreData

class BudgetModelManager {

    static let sharedInstance = BudgetModelManager()
    
    var budgets = [Budget]()

    func fetchBudgets() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Budget")
        
        do {
            let budgetObjects = try context.executeFetchRequest(request) as! [MOMBudget]
            
            for budgetObject in budgetObjects {
                
                let budget = Budget()
                budget.title = budgetObject.title ?? ""
                
                for budgetItemObject in budgetObject.budgetItem! {
                    
                    let budgetItemName:String = budgetItemObject.name! ?? ""
                    let budgetItemValue:Double = Double(budgetItemObject.value!) ?? 0
                    let budgetItemType = budgetItemObject.type!
                    
                    let budgetItem = Budget.BudgetItem(name: budgetItemName, value: budgetItemValue)
                    
                    if budgetItemType == "expense" {
                        budget.expenses.append(budgetItem)
                    } else if budgetItemType == "income" {
                        budget.incomes.append(budgetItem)
                    } else {
                        // Something went wrong, do nothing
                    }
                }
                budgets.append(budget)
            }
        
        } catch {
            print("There was an error fetching data: \(error)")
        }
    }
    
    
    func saveBudgets() {
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        for budget in budgets {
                        
            let budgetObject = NSEntityDescription.insertNewObjectForEntityForName("Budget", inManagedObjectContext: context) as! MOMBudget
            
            budgetObject.title = budget.title
//            budgetObject.budgetItem = NSSet<MOMBudgetItem>()
            
            for expense in budget.expenses {
                
                let expenseObject = NSEntityDescription.insertNewObjectForEntityForName("BudgetItem", inManagedObjectContext: context) as! MOMBudgetItem

                expenseObject.name = expense.name
                expenseObject.value = expense.value
                expenseObject.type = "expense"
                expenseObject.budget = budgetObject
                
                budgetObject.budgetItem?.insert(expenseObject)
            }
            
            for income in budget.incomes {
                
                let incomeObject = NSEntityDescription.insertNewObjectForEntityForName("BudgetItem", inManagedObjectContext: context) as! MOMBudgetItem
                
                incomeObject.name = income.name
                incomeObject.value = income.value
                incomeObject.type = "income"
                incomeObject.budget = budgetObject
                
                budgetObject.budgetItem.insert(incomeObject)

            }
        }
        
        do {
            try context.save()
        
        } catch {
            print("There was an error saving data: \(error)")
        }
    }
    
    
}