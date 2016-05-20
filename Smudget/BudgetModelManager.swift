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

    // MARK: Singleton instance getter
    static let sharedInstance = BudgetModelManager()
    
    // MARK: Properties
    var budgets = [Budget]()
    
    // MARK: Generating my own IDs
    private static var lastID = 0
    static func nextID() -> Int {
        return ++BudgetModelManager.lastID
    }
    
    func fetchBudgetObjects(predicate: NSPredicate?) -> [MOMBudget] {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Budget")
        
        if predicate != nil {
            request.predicate = predicate
        }
        
        do {
            return try context.executeFetchRequest(request) as! [MOMBudget]
        } catch {
            print("There was an error fetching data: \(error)")
        }
        
        // There has been an error, return an empty array.
        // This is better than crashing the application
        // from failing to unwrap a nil return
        return [MOMBudget]()
    }
    
    func loadBudgets() {
    
        let budgetObjects = fetchBudgetObjects(nil)
    
        for budgetObject in budgetObjects {
            
            let budget = Budget()
            budget.title = budgetObject.title ?? ""
            // Default to AUD cause it's the easy way out
            budget.currency = budgetObject.currency ?? "AUD"
            budget.id = Int(budgetObject.id!)
            
            for object in budgetObject.budgetItem! {
                
                let budgetItemObject = object as! MOMBudgetItem
                
                let budgetItemName:String = budgetItemObject.name! ?? ""
                let budgetItemValue:Double = Double(budgetItemObject.value!) ?? 0
                let budgetItemType = budgetItemObject.type
                
                let budgetItem = Budget.BudgetItem(name: budgetItemName, value: budgetItemValue)
                
                if budgetItemType == "expense" {
                    budget.expenses.append(budgetItem)
                } else if budgetItemType == "income" {
                    budget.incomes.append(budgetItem)
                } else {
                    // budget item had no type, for some reason.
                    // discard it
                }
            }
            budgets.append(budget)
        }
    
    }
    
    
    func saveBudgets() {
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        for budget in budgets {
            
            let existingBudgetObject = fetchBudgetObjects(NSPredicate(format: "id == %d", budget.id))
            var budgetObject:MOMBudget! = existingBudgetObject.first
            
            if budgetObject == nil {
                budgetObject = NSEntityDescription.insertNewObjectForEntityForName("Budget", inManagedObjectContext: context) as? MOMBudget
            }
            
            budgetObject.title = budget.title
            budgetObject.currency = budget.currency
            budgetObject.budgetItem = Set<MOMBudgetItem>()
            
            for expense in budget.expenses {
                
                let expenseObject = NSEntityDescription.insertNewObjectForEntityForName("BudgetItem", inManagedObjectContext: context) as! MOMBudgetItem

                expenseObject.name = expense.name
                expenseObject.value = expense.value
                expenseObject.type = "expense"
                expenseObject.budget = budgetObject
                
                budgetObject.addBudgetItemObject(expenseObject)
            }
            
            for income in budget.incomes {
                
                let incomeObject = NSEntityDescription.insertNewObjectForEntityForName("BudgetItem", inManagedObjectContext: context) as! MOMBudgetItem
                
                incomeObject.name = income.name
                incomeObject.value = income.value
                incomeObject.type = "income"
                incomeObject.budget = budgetObject
                
               budgetObject.addBudgetItemObject(incomeObject)

            }
        }
        
        do {
            try context.save()
        
        } catch {
            print("There was an error saving data: \(error)")
        }
    }
    
    
    

}