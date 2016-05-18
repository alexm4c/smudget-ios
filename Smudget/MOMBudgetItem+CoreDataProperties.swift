//
//  MOMBudgetItem+CoreDataProperties.swift
//  
//
//  Created by Alex Mc Bain on 18/05/2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MOMBudgetItem {

    @NSManaged var name: String?
    @NSManaged var value: NSNumber?
    @NSManaged var type: String?
    @NSManaged var budget: MOMBudget?

}
