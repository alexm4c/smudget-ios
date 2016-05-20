//
//  ExistingBudgetViewController.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit
import AVFoundation

class ExistingBudgetViewController: UITableViewController {
    
    // MARK: Table View Delegation
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BudgetModelManager.sharedInstance.budgets.count
    }
    
    // Populating tableview
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BudgetTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgetTableViewCell
        let budget = BudgetModelManager.sharedInstance.budgets[indexPath.row]
        cell.budgetTitleLabel.text = budget.title
        
        return cell
    }
    
    // Edit function for deleting a budget
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            BudgetModelManager.sharedInstance.budgets.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.reloadData()
        }
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navigationC = segue.destinationViewController as? UINavigationController {
            if let destinationVC = navigationC.viewControllers.first as? BudgetViewController {
                if segue.identifier == "existingToBudgetSegue" {
                    if let budgetIndex = tableView.indexPathForSelectedRow?.row {
                        destinationVC.budget = BudgetModelManager.sharedInstance.budgets[budgetIndex]
                    }
                }
            }
        }
    }
    
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        BudgetModelManager.sharedInstance.budgets.shuffleInPlace()
        self.tableView.reloadData()
        
        let alert = UIAlertController(title: "Whoops!", message: "", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
    }

}