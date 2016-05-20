//
//  MOMBudget+CoreDataProperties.swift
//  
//
//  Created by Alex Mc Bain on 20/05/2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MOMBudget {

    @NSManaged var currency: String?
    @NSManaged var title: String?
    @NSManaged var id: NSNumber?
    @NSManaged var budgetItem: NSSet?
    
    
    @NSManaged func addBudgetItemObject(value:MOMBudgetItem)
    @NSManaged func removeBudgetItemObject(value:MOMBudgetItem)
    @NSManaged func addBudgets(value:Set<MOMBudgetItem>)
    @NSManaged func removeBudgets(value:Set<MOMBudgetItem>)
}
