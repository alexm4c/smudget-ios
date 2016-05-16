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

    private static let ENTITY_BUDGET    = "Budget"
    private static let ATTRIB_TITLE     = "title"
    private static let RELATN_EXPENSE   = "expense"
    private static let RELATN_INCOME    = "income"
    
    private static let ENTITY_EXPENSE   = "Expense"
    private static let ENTITY_INCOME    = "Income"
    private static let ATTRIB_NAME      = "name"
    private static let ATTRIB_VALUE     = "value"
    private static let RELATN_BUDGET    = "budget"
    
    static let sharedInstance = BudgetModelManager()
    
    var budgets = [Budget]()

    func fetchBudgets() {
        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let context = appDelegate.managedObjectContext
//        let request = NSFetchRequest(entityName: BudgetModelManager.ENTITY_BUDGET)
//        
//        do {
//            let objects = try context.executeFetchRequest(request)
//            
//            for object in objects {
//                
//                let budget = Budget()
//                budget.title = object.valueForKey(BudgetModelManager.ATTRIB_TITLE) as? String ?? ""
//                
//                
//                
//                
//                if let expenseObjects = object.valueForKey(BudgetModelManager.RELATN_EXPENSE) as? [NSManagedObject] {
//                
//                    for expenseObject in expenseObjects {
//                    
//                        
//                    
//                
//                    }
//                
//                }
//                
//                
//                
//                budgets.append(budget)
//            }
//        
//        } catch {
//            print("There was an error fetching data: \(error)")
//        }
    }
    
    
    func saveBudgets() {
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        for budget in budgets {
            
            let budgetEntity = NSEntityDescription.entityForName(BudgetModelManager.ENTITY_BUDGET, inManagedObjectContext: context)
            let budgetObject = NSManagedObject(entity: budgetEntity!, insertIntoManagedObjectContext: context)
            
            budgetObject.setValue(budget.title, forKey: BudgetModelManager.ATTRIB_TITLE)
            
            for expense in budget.expenses {
                
                let expenseEntity = NSEntityDescription.entityForName(BudgetModelManager.ENTITY_EXPENSE, inManagedObjectContext: context)
                let expenseObject = NSManagedObject(entity: expenseEntity!, insertIntoManagedObjectContext: context)
                
                expenseObject.setValue(expense.name, forKey: BudgetModelManager.ATTRIB_NAME)
                expenseObject.setValue(expense.value, forKey: BudgetModelManager.ATTRIB_VALUE)
                
                expenseObject.setValue(NSSet(object: budgetObject), forKey: BudgetModelManager.RELATN_BUDGET)
            }
            
            for income in budget.incomes {
                
                let incomeEntity = NSEntityDescription.entityForName(BudgetModelManager.ENTITY_INCOME, inManagedObjectContext: context)
                let incomeObject = NSManagedObject(entity: incomeEntity!, insertIntoManagedObjectContext: context)
                
                incomeObject.setValue(income.name, forKey: BudgetModelManager.ATTRIB_NAME)
                incomeObject.setValue(income.value, forKey: BudgetModelManager.ATTRIB_VALUE)
                
                incomeObject.setValue(NSSet(object: budgetObject), forKey: BudgetModelManager.RELATN_BUDGET)
            }
        }
        
        do {
            try context.save()
        
        } catch {
            print("There was an error saving data: \(error)")
        }
    }
    
    
}